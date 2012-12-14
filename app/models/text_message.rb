# This class returns the correct message
# 1 it finds or creates a new chatter based upon phone number
# 2 it sets the brand 
# 3 it sets the session if one was found today. if not, it creates a new one

class TextMessage
  def initialize(phone, message, sms_service_name="text caster", receiving_phone=nil, sessionid = nil)
    @chatter_phone = phone
    @message = message.downcase
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
  
  def brand_number
    @our_phone
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
    find_brand || find_brand_by_phone || set_brand_by_last_session
  end
  
  def find_brand
    brand = Brand.where(:name => @message).count 
    brand > 1 ? nil : @brand = Brand.find_by_name(@message)
  end
  
  
  def find_brand_by_phone
    phones = BrandSetting.where(:setting => @our_phone )
    if phones.size > 1
     phone =  phones.find_all { |x| x.brand.name==@message}.first
     brand.nil? ? nil : @brand = phone.brand
    elsif phones.size == 1
      @brand = phones.first.brand
    else
      nil
    end
  end
  
  
  def set_tag
    @tag = Tag.find_by_name(@message)
  end
  
  def set_action
    @action = Category.find_by_name(@message)
  end  
  
  
  # look up the chatter's last session and set the brand
  def set_brand_by_last_session
    @brand = @chatter.text_sessions.blank? ? Brand.first : @chatter.text_sessions.last.brand
  end
  
  # grab today's session with the chatter, return the last one
  # if no sessions, create a new one for today
  def set_session
    if @chatter.text_sessions.today.blank?
      @session = @chatter.text_sessions.create(:brand => @brand, :session => @sessionid)
    else
      @session = @chatter.text_sessions.today.first
      if @session.brand != @brand
        @session.update_attributes(:brand => @brand)
      end
      @session
    end
  end
  
  def get_response
    if is_keyword 
    elsif is_list
    elsif is_tag
    elsif is_action
    elsif is_test
    elsif is_typo
    elsif is_next
    elsif is_help
    elsif is_tag_in_text
    elsif is_action_in_text
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
      @response = @brand.list_tags.setting
      add_history('list')
      return true
    end
  end
  
  def add_history(text_type, tag=nil, category=nil, flag=false, text_content=nil)
    @session.text_histories.create!(:tag => tag, :category => category, :text => @message, :response => @response, :text_type => text_type, :flag => flag, :text_content => text_content)      
  end
  
  def tag_list
    @brand.text_contents.joins(:tag).map { |x| x.tag.name}.sort
  end
  
  def action_list
    @brand.text_contents.joins(:category).map { |x| x.category.name}.sort
  end

  def is_tag
    if !@tag.nil?
      tag_actions
      if @actions.include?('no action')
        @response = tag_action_array.last.response
        add_history('tag', @tag, tag_action_array.last.category )
      elsif !@actions.blank?
        @response = "Respond with #{@actions}"
        add_history('tag', @tag)
      else
        return false
      end
      return true
    end
  end
  
  def tag_actions
    actions = tag_action_array
    f = actions.map {|x| x.category.name}
    f << "get help" unless @brand.organizations.tagged_with(@tag.name).blank?
    @actions = f.to_sentence(:words_connector => ', ', :last_word_connector => ' or ', :two_words_connector =>' or ')
  end
  
  def tag_action_array
    @brand.text_contents.joins(:category).where(:tag_id => @tag.id)
  end
  
  def is_action
    if !@action.nil?
      action_text
      add_history('action', @tag, @action, false, @text_content)
      return true
    end
  end
  
  def action_text
    if !@session.text_histories.blank?
      @tag = @session.text_histories.where("tag_id is NOT NULL").last.tag
      @text_content = TextContent.where(:tag_id => @tag.id, :category_id => @action.id, :brand_id => @brand.id).first
      @response = @text_content.response
    else
      @response = @brand.info_not_found.setting
    end
  end
  
  def is_typo
    tag_typo = TagTypo.find_by_typo(@message)
    if !tag_typo.blank?
    if tag_typo.tag
      @tag = tag_typo.tag
      is_tag
    else
      @action = tag_typo.category
      is_action
    end 
    end
  end
  
  def not_found
    @response = @brand.info_not_found.setting
    add_history('not found', @session.text_histories.last.tag, nil, true)
  end  
  
  def is_test
    if ['hlep', 'gt help', 'get hlp', 'get hlep', 'test', 'hlpe', 'get help', 'help'].include?(@message.downcase)
      @response = "Respond with your zipcode for a list of local places to get help. You can also text next for another clinic."
      add_history('help', @session.text_histories.last.tag)
      return true
    end
  end
  
  def is_help
    if @session.text_histories.last.text_type == 'help' and @message.to_i > 0
      @session.chatter.update_attributes(:zipcode => @message)
      orgs = get_org_list(@message, @session.text_histories.last.tag)
      if orgs.blank?
        @response = @brand.organization_not_found.setting
        add_history('help', @session.text_histories.last.tag, nil, true)        
      else
        @response = orgs.first.sms_about
        add_history('help', @session.text_histories.last.tag)        
      end
      return true
    end
  end    
  
  def is_next
    if ['next', 'nxt', 'enxt', 'nxet'].include?(@message.downcase)
      org_list = get_org_list(@chatter.zipcode, @session.text_histories.last.tag)
      if !org_list.blank?
        @response = get_next_org(org_list, @session.text_histories.last.response).sms_about
        add_history('help',@session.text_histories.last.tag)        
      else
        @response = @brand.organization_not_found.setting
        add_history('help', @session.text_histories.last.tag, nil, true)        
      end

      return true
    end
  end
  
  def get_next_org(org_array, last_response)
    s = org_array.index(org_array.detect{|o| o.sms_about == last_response})+1
    return org_array.fetch(s, org_array.first)
  end

  def get_org_list(zip=@message, tag=@tag)
    # get list of organizations by tag
    org_list_tag = @brand.organizations.tagged_with(tag.name)
    # get list of organizations ordered by distance
    org_list_distance = Organization.near(zip, @brand.distance_for_organization.setting)
    # go through list of distance_orgs and delete if not in the tagged organizations
    org_list = []
    org_list_distance.each { |x| org_list << x unless !org_list_tag.include?(x) }
    org_list
  end
  
  def is_tag_in_text
    # grab a list of tags
    tag = tag_list.detect { |tag| @message.downcase.include?(tag.downcase)}
    if tag
      @tag = Tag.where(:name => tag).first
      get_response
    end
  end
  
  def is_action_in_text
    # grab a list of actions
    action = action_list.detect { |action| @message.downcase.include?(action.downcase)}
    if action
      @action = Category.where(:name => action).first
      get_response
    end
  end
    
end
