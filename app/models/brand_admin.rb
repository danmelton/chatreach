class BrandAdmin < ActiveRecord::Base
  
  belongs_to :brand
  belongs_to :user
  
  validates_presence_of :user_id, :brand_id
  
end
