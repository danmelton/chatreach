# Brands are unique names required to start sessions via texts.
# They have settings as well and only can be edited by administrators
class Brand < ActiveRecord::Base
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  has_many :brand_admins
  has_many :admins, :through => :brand_admins, :source => :user
end
