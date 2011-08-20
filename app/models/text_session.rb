class TextSession < ActiveRecord::Base
  has_many :text_histories, :dependent => :destroy
  belongs_to :chatter
  belongs_to :brand
  
  validates_presence_of :chatter, :on => :create, :message => "can't be blank"
  validates_presence_of :brand, :on => :create, :message => "can't be blank"
  
end
