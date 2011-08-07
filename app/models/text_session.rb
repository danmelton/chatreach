class TextSession < ActiveRecord::Base
  has_many :text_histories
  belongs_to :chatter
  belongs_to :carrier
  belongs_to :brand
  belongs_to :account
  
  named_scope :between_created_dates, lambda { |start_date, end_date| {:conditions => ['text_sessions.created_at >=? and text_sessions.created_at <=? ', start_date, end_date] } }
  named_scope :between_updated_dates, lambda { |start_date, end_date| {:conditions => ['text_sessions.updated_at >=? and text_sessions.updated_at <=? ', start_date, end_date] } }  
end
