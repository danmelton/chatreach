class Keyword < ActiveRecord::Base
  belongs_to :brand
  
  validates_presence_of :weight, :on => :create, :message => "can't be blank"
  validates_presence_of :content, :on => :create, :message => "can't be blank"
  validates_presence_of :brand, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :content, :on => :create, :scope => :brand_id, :message => "must be unique"
end
