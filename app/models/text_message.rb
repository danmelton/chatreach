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
    set_action
    set_tag
  end
    
  def chatter
    @chatter
  end
  
  def brand
    @brand
  end

  def service
    @service
  end
  
  def session
    @session
  end
    
  def action
    @action
  end
  
  def tag
    @tag
  end
  
  def actions
    @actions
  end
  
  def set_chatter
    @chatter = Chatter.find_or_create_by_phone(@chatter_phone)
  end
  
  def response
    @response
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
  
  def set_tag
    @tag = Tag.find_by_name(@message)
  end
  
  def set_action
    @action = Category.find_by_name(@message)
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
  
  # grab today's session with the chatter, return the last one
  # if no sessions, create a new one for today
  def set_session
    if @chatter.text_sessions.today.blank?
      @session = @chatter.text_sessions.create(:brand => @brand, :session => @sessionid)
    else
      @session = @chatter.text_sessions.today.first
    end
  end
  
  def set_response
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
  
  def is_keyword
    if @message.downcase.include?(@brand.name)
      @response = @brand.welcome.setting
      add_history('keyword')
      return true
    end
  end
  

  def is_list
    if @message.downcase.include?('list')
      @response = tag_list.join(", ")
      add_history('list')
      return true
    end
  end
  
  def add_history(text_type, tag=nil, category=nil)
    @session.text_histories.create!(:tag => tag, :text => @message, :response => @response, :text_type => text_type)      
  end
  
  def tag_list
    @brand.text_contents.joins(:tag).map { |x| x.tag.name}.sort
  end

  def is_tag
    if !@tag.nil?
      tag_actions
      if @actions.include?('no action')
        @response = tag_action_array.last.response
        add_history('tag', @tag, tag_action_array.last.category )
      else
        @response = "Respond with #{@actions}"
        add_history('tag', @tag)
      end
      return true
    end
  end
  
  def tag_actions
    actions = tag_action_array
    f = actions.map {|x| x.category.name}
    f << "get help"
    @actions = f.to_sentence(:words_connector => ', ', :last_word_connector => ' or ', :two_words_connector =>' or ')
  end
  
  def tag_action_array
    @brand.text_contents.joins(:category).where(:tag_id => @tag.id)
  end
  
  def is_action
    if !@action.nil?
      action_text
      add_history('action', @tag)
      return true
    end
  end
  
  def action_text
    if !@session.text_histories.blank?
      @tag = @session.text_histories.last.tag
      @response = TextContent.where(:tag_id => @tag.id, :category_id => @action.id, :brand_id => @brand.id).first.response
    else
      @response = @brand.welcome.setting
    end
  end
  
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