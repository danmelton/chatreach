class TextMessage
  def initialize(sessionid, phone, carrier, message)
    @sessionid = sessionid
    @phone = phone
    @carrier = carrier
    @message = message
    set_chatter    
    set_keyword_and_session
    set_tag
    set_action
  end
  
  def keyword
    @keyword
  end
    
  def account
    @account
  end
    
  def chatter
    @chatter
  end
  
  def set_chatter
    if ChatterProfile.find_by_phone(@phone).nil?
      @chatter = Chatter.create
      @chatter.create_chatter_profile(:phone => @phone)
    else
      @chatter = ChatterProfile.find_by_phone(@phone).chatter
    end
  end
  
  def response
    if is_keyword 
    elsif is_list
    elsif is_tag
    elsif is_action
    elsif is_test
    elsif is_typo
    elsif is_next
    elsif is_help
    else not_found
    end
    @response
  end
  
  def session
    @session
  end

  def set_keyword_and_session
    keyword = BrandSetting.with_keyword(@message)
    @session = TextSession.find_by_session(@sessionid)
    if keyword.blank?
      @session.updated_at = Time.now
      @session.save
      @brand = @session.brand
      @account = @session.account
      @keyword = BrandSetting.with_account_and_brand(@account.id,@brand.id).first
    elsif @session.nil?
      @keyword = keyword.first
      @carrier = Carrier.find_by_carrierid(@carrier)
      @brand = @keyword.brand
      @account = @keyword.account
      @session = TextSession.create!(:carrier => @carrier, :session => @sessionid, :chatter => @chatter, :account => @account, :brand => @brand, :phone => @phone)      
    else
      @keyword = keyword.first
      @session.update_attributes(:updated_at => Time.now, :account => @keyword.account)
      @brand = @session.brand
      @account = @keyword.account
    end

  end
  
  def action
    @action
  end
  
  def set_action
    @action = Category.find_by_name(@message)
  end

  def tag
    @tag
  end

  def set_tag
    @tag = Brand.find_by_name('Sext').tags.find_by_name(@message)
  end

  
  def charge
  end
  
  def is_keyword
    if @message.downcase.include?(@keyword.setting.downcase)
      @response = BrandSetting.description_for_keyword(@account.id, @brand.id).first.setting
      @session.text_histories.create(:tag => Tag.find_by_name(@message), :text => @message, :response => @response, :text_type => 'keyword')
      return true
    end
  end
  
  def is_list
    if @message.downcase.include?('list')
      @response = Brand.find(2).tags.join(", ")
      return true
    end
  end
  
  def is_tag
    if !@tag.nil?
      f = []
      TextContent.published.tagged_with(@message, :on => :sext).map{|x| f << x.categories.last.name}
      f << "get help"
      @actions = f.to_sentence(:words_connector => ', ', :last_word_connector => ' or ', :two_words_connector =>' or ')
      if @actions.include?('no action')
      @response = TextContent.published.tagged_with(@tag.name, :on => :sext).last.response
      else
      @response = "Respond with #{@actions}"
      end
      @session.text_histories.create(:tag => Tag.find_by_name(@message), :text => @message, :response => @response, :text_type => 'tag')
      return true
    end
  end
  
  def is_action
    if !@action.nil?
      @response = TextContent.published.tagged_with(@session.text_histories.last.tag.name, :on => :sext).with_category(self.action.id).last.response
      @session.text_histories.create(:tag =>@session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'action')
      return true
    end
  end
  
  def is_test
    if ['hlep', 'gt help', 'get hlp', 'get hlep', 'test', 'hlpe', 'get help', 'help'].include?(@message.downcase)
      @response = "Respond with your zipcode for a list of local places to get help. You can also text next for another clinic."
      @session.text_histories.create!(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'help')
      return true
    end
  end
  
  def is_next
    if ['next', 'nxt', 'enxt', 'nxet'].include?(@message.downcase)
      zip = Geocoding::get(@chatter.chatter_profile.zipcode)
      @response = get_next_org(get_org_list(zip), self.session.text_histories.last.response)
      self.session.text_histories.create!(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'help')
      return true
    end
  end
  
  def get_next_org(org_array, last_response)
    s = org_array.index(org_array.detect{|o| o.sms_about == last_response})+1
    return org_array.fetch(s, org_array.first).sms_about
  end
  
  def is_help
    if @session.text_histories.last.text_type == 'help' and @message.to_i > 0
      @session.chatter.chatter_profile.update_attributes!(:zipcode => @message)
      zip = Geocoding::get(@message)
      get_org_list(zip)
      @session.text_histories.create!(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'help')
      return true
    end
  end
  
  
  def get_org_list(zip)
    oprofile = @account.account_organizations.with_brand(@brand.id).map(&:oprofile_id).join(",")
    if oprofile ==''  
      @response = BrandSetting.description_for_not_found(@account.id, @brand.id).first.setting
    elsif Oprofile.linked(oprofile).tagged_with(@session.text_histories.last.tag, :on => :sext).m_circle(zip[0].longitude, zip[0].latitude, 50).blank?
      @response = BrandSetting.description_for_not_found(@account.id, @brand.id).first.setting
    else
      @list = Oprofile.linked(oprofile).tagged_with(@session.text_histories.last.tag, :on => :sext).m_circle(zip[0].longitude, zip[0].latitude, 50)
      @response = Oprofile.linked(oprofile).tagged_with(@session.text_histories.last.tag, :on => :sext).m_circle(zip[0].longitude, zip[0].latitude, 50).first.sms_about
    end
    return @list
  end
  
  def is_typo
    tag = TagTypo.find_by_typo(@message)
    if tag
       f = []
       TextContent.tagged_with(tag.tag.name, :on => :sext).map{|x| f << x.categories.last.name}
       @actions = f.to_sentence(:words_connector => ', ', :last_word_connector => ' or ', :two_words_connector =>' or ')
       @session.text_histories.create(:tag => tag.tag, :text => @message, :response => @response, :text_type => 'tag')
       @response = "Respond with #{@actions}"
       return true
     end
  end
  
  def not_found
    @session.text_histories.create(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'not found')
    @response = BrandSetting.description_for_info_not_found(@account.id, @brand.id).first.setting
  end
  
  
  
end