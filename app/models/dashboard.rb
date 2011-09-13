require 'open-uri'
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
  
  def parse_wiki
    Feedzirra::Feed.fetch_and_parse("https://chatreachwiki.pbworks.com/w/feed/rss")
  end
  
  def text_history
    TextHistory.where("created_at > '#{30.days.ago}'")
  end
  
  def group_texters
    TextHistory.includes(:text_session).where("text_histories.created_at > '#{30.days.ago}'").group("text_sessions.chatter_id")
  end
  
  def texters
    group_texters.size
  end
  
  def texters_over_one_message
    a=1
    self.texters.each { |x| if x.last > 1 then a=a+1 end}
    a
  end
  
  def texters_over_five_messages
    a=1
    self.texters.each { |x| if x.last > 5 then a=a+1 end}
    a    
  end
  
  def new_chatters
    Chatter.where("created_at > '#{30.days.ago}'")
  end
  
  def text_referrals
    TextHistory.includes(:text_session).where("text_histories.created_at > '#{30.days.ago}' and text_type='help'").group("text_sessions.chatter_id")    
  end
  
end