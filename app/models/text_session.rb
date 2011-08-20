class TextSession < ActiveRecord::Base
  has_many :text_histories, :dependent => :destroy
  belongs_to :chatter
  belongs_to :brand
  
  scope :today, where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day)
  
  validates_presence_of :chatter, :on => :create, :message => "can't be blank"
  validates_presence_of :brand, :on => :create, :message => "can't be blank"
  
end
