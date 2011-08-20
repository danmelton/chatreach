# This class returns the correct message
# 1 it finds or creates a new chatter based upon phone number
# 2 it sets the brand 
# 3 it sets the session if one was found today. if not, it creates a new one

class TextMessage
  def initialize(phone, message, sms_service_name="text caster", receiving_phone=nil, sessionid = nil)
    @chatter_phone = phone
    @message = message
    @service = sms_service_name
    @sessionid = sessionid
    @our_phone = receiving_phone
    set_chatter
    set_brand
    set_session
  end
    
  def chatter
    @chatter
  end
  
  def brand
    @brand
  end
  
  def set_chatter
    @chatter = Chatter.find_or_create_by_phone(@chatter_phone)
  end
  
  # If the brand isn't texted in first, then check out the chatter to see if they texted in before.
  # If they haven't, then get the brand from the referring phone number
  # If they have, then get the brand from the last session
  
  def set_brand
    if find_brand.nil?
      @chatter.text_sessions.last.blank? ? set_brand_by_phone : set_brand_by_last_session
    end
  end
  
  def find_brand
    @brand = Brand.find_by_name(@message.downcase)
  end
  
  # Look up brand setting by our phone, return the first brand result
  def set_brand_by_phone
    brand_setting = BrandSetting.where(:setting => @our_phone )
    if brand_setting.blank?
      @brand = Brand.all.first
    else
      @brand = brand_setting.first.brand
    end
  end
  
  # look up the chatter's last session and set the brand
  def set_brand_by_last_session
    @brand = @chatter.text_sessions.last.brand
  end

  def service
    @service
  end

  # grab today's session with the chatter, return the last one
  # if no sessions, create a new one for today
  def set_session
    if @chatter.text_sessions.today.blank?
      @session = @chatter.text_sessions.create(:brand => @brand, :session => @sessionid)
    else
      @session = @chatter.text_sessions.today.first
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
    
  def action
    @action
  end
  
  def set_action
    @action = Category.find_by_name(@message)
  end
    # 
    # def tag
    #   @tag
    # end
    # 
    # def set_tag
    #   @tag = Tag.find_by_name(@message)
    # end
    # 
    # def is_keyword
    #   if @message.downcase.include?(@keyword.setting.downcase)
    #     @response = BrandSetting.description_for_keyword(@account.id, @brand.id).first.setting
    #     @session.text_histories.create(:tag => Tag.find_by_name(@message), :text => @message, :response => @response, :text_type => 'keyword')
    #     return true
    #   end
    # end
    # 
    # def is_list
    #   if @message.downcase.include?('list')
    #     @response = Brand.find(2).tags.join(", ")
    #     return true
    #   end
    # end
    # 
    # def is_tag
    #   if !@tag.nil?
    #     f = []
    #     TextContent.published.tagged_with(@message, :on => :sext).map{|x| f << x.categories.last.name}
    #     f << "get help"
    #     @actions = f.to_sentence(:words_connector => ', ', :last_word_connector => ' or ', :two_words_connector =>' or ')
    #     if @actions.include?('no action')
    #     @response = TextContent.published.tagged_with(@tag.name, :on => :sext).last.response
    #     else
    #     @response = "Respond with #{@actions}"
    #     end
    #     @session.text_histories.create(:tag => Tag.find_by_name(@message), :text => @message, :response => @response, :text_type => 'tag')
    #     return true
    #   end
    # end
    # 
    # def is_action
    #   if !@action.nil?
    #     @response = TextContent.published.tagged_with(@session.text_histories.last.tag.name, :on => :sext).with_category(self.action.id).last.response
    #     @session.text_histories.create(:tag =>@session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'action')
    #     return true
    #   end
    # end
    # 
    # def is_test
    #   if ['hlep', 'gt help', 'get hlp', 'get hlep', 'test', 'hlpe', 'get help', 'help'].include?(@message.downcase)
    #     @response = "Respond with your zipcode for a list of local places to get help. You can also text next for another clinic."
    #     @session.text_histories.create!(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'help')
    #     return true
    #   end
    # end
    # 
    # def is_next
    #   if ['next', 'nxt', 'enxt', 'nxet'].include?(@message.downcase)
    #     zip = Geocoding::get(@chatter.chatter_profile.zipcode)
    #     @response = get_next_org(get_org_list(zip), self.session.text_histories.last.response)
    #     self.session.text_histories.create!(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'help')
    #     return true
    #   end
    # end
    # 
    # def get_next_org(org_array, last_response)
    #   s = org_array.index(org_array.detect{|o| o.sms_about == last_response})+1
    #   return org_array.fetch(s, org_array.first).sms_about
    # end
    # 
    # def is_help
    #   if @session.text_histories.last.text_type == 'help' and @message.to_i > 0
    #     @session.chatter.chatter_profile.update_attributes!(:zipcode => @message)
    #     zip = Geocoding::get(@message)
    #     get_org_list(zip)
    #     @session.text_histories.create!(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'help')
    #     return true
    #   end
    # end
    # 
    # 
    # def get_org_list(zip)
    #   oprofile = @account.account_organizations.with_brand(@brand.id).map(&:oprofile_id).join(",")
    #   if oprofile ==''  
    #     @response = BrandSetting.description_for_not_found(@account.id, @brand.id).first.setting
    #   elsif Oprofile.linked(oprofile).tagged_with(@session.text_histories.last.tag, :on => :sext).m_circle(zip[0].longitude, zip[0].latitude, 50).blank?
    #     @response = BrandSetting.description_for_not_found(@account.id, @brand.id).first.setting
    #   else
    #     @list = Oprofile.linked(oprofile).tagged_with(@session.text_histories.last.tag, :on => :sext).m_circle(zip[0].longitude, zip[0].latitude, 50)
    #     @response = Oprofile.linked(oprofile).tagged_with(@session.text_histories.last.tag, :on => :sext).m_circle(zip[0].longitude, zip[0].latitude, 50).first.sms_about
    #   end
    #   return @list
    # end
    # 
    # def is_typo
    #   tag = TagTypo.find_by_typo(@message)
    #   if tag
    #      f = []
    #      TextContent.tagged_with(tag.tag.name, :on => :sext).map{|x| f << x.categories.last.name}
    #      @actions = f.to_sentence(:words_connector => ', ', :last_word_connector => ' or ', :two_words_connector =>' or ')
    #      @session.text_histories.create(:tag => tag.tag, :text => @message, :response => @response, :text_type => 'tag')
    #      @response = "Respond with #{@actions}"
    #      return true
    #    end
    # end
    # 
    # def not_found
    #   @session.text_histories.create(:tag => session.text_histories.last.tag, :text => @message, :response => @response, :text_type => 'not found')
    #   @response = BrandSetting.description_for_info_not_found(@account.id, @brand.id).first.setting
    # end
    # 
    # 
  
end