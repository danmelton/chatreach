class BrandTag < ActiveRecord::Base
  belongs_to :brand
  belongs_to :tag
  
end
