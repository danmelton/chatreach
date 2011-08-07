class Carrier < ActiveRecord::Base
  has_many :text_sessions
  attr_accessible :name, :carrierid
  
  validates_uniqueness_of :carrierid, :on => :create, :message => "must be unique"
  
end
