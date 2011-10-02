require 'open-uri'
class Dashboard
  
  def initialize(brand=nil, time1 = 30.days.ago, time2=Time.now)
    @time1 = time1.to_time
    @time2 = time2.to_time
    @brand = brand
  end
  
  def get_started?
    if check_brands and check_tags and check_actions and check_text_contents and check_organizations
      false
    else
      true
    end
  end
  
  def brand
    @brand
  end
  
  def time1
    @time1
  end
  
  def time2
    @time2
  end
  
  def time_elapsed
    ((@time2 - @time1)/86400).to_i
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
    if @brand
      TextHistory.includes(:text_session).where("text_sessions.brand_id = #{@brand.id} and text_histories.created_at > '#{@time1}' and text_histories.created_at < '#{@time2}'")
    else
      TextHistory.includes(:text_session).where("text_histories.created_at > '#{@time1}' and text_histories.created_at < '#{@time2}'")
    end
  end
  
  def group_texters
    if @brand
      TextHistory.includes(:text_session).where("text_sessions.brand_id = #{@brand.id} and text_histories.created_at > '#{@time1}' and text_histories.created_at < '#{@time2}'").group("text_sessions.chatter_id")
    else
      TextHistory.includes(:text_session).where("text_histories.created_at > '#{@time1}' and text_histories.created_at < '#{@time2}'").group("text_sessions.chatter_id")
    end
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
    if @brand
      Chatter.includes(:text_sessions).where("text_sessions.brand_id = #{@brand.id} and chatters.created_at > '#{@time1}' and chatters.created_at < '#{@time2}'")
    else
      Chatter.where("created_at > '#{@time1}' and created_at < '#{@time2}'")
    end
  end
  
  def text_referrals
    if @brand
      TextHistory.includes(:text_session).where("text_sessions.brand_id =#{@brand.id} and text_histories.created_at > '#{@time1}' and text_histories.created_at < '#{@time2}' and text_type='help'").group("text_sessions.chatter_id")        
    else
      TextHistory.includes(:text_session).where("text_histories.created_at > '#{@time1}' and text_histories.created_at < '#{@time2}' and text_type='help'").group("text_sessions.chatter_id")    
    end
  end
  
end