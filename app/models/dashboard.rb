class Dashboard
  
  def get_started?
    if check_brands and check_tags and check_actions and check_text_contents and check_organizations
      false
    else
      true
    end
  end
  
  def check_brands
    Brand.count > 0
  end
  
  def check_tags
    Tag.count > 0
  end
  
  def check_actions
    Category.count > 0
  end
  
  def check_text_contents
    TextContent.count > 0
  end
  
  def check_organizations
    Organization.count > 0
  end
  
  def check_users
    User.count > 1
  end
  
  def check_chatters
    Chatter.count > 5
  end
  
  
end