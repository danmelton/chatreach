class TextHistory < ActiveRecord::Base
  belongs_to :tag
  belongs_to :category
  belongs_to :text_session
  belongs_to :text_content, :class_name => "TextContent", :foreign_key => "text_content_id"  
  
  validates_presence_of :response, :text_session, :text_type
  
  scope :between_created_dates, lambda { |account, start_date, end_date| { :include => :text_session, :conditions => ['text_sessions.account_id = ? and text_histories.created_at >=? and text_histories.created_at <=? ', account, start_date, end_date] } }
  scope :average_count, lambda { |account, start_date, end_date| { :select => "text_histories.count(*) as count_all, text_sessions.updated_at", :include => :text_session, :group => "text_histories.text_session_id", :conditions => ['text_sessions.account_id = ? and text_histories.created_at >=? and text_histories.created_at <=? ', account, start_date, end_date] } }  
end
