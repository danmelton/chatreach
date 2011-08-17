class BrandOrganization < ActiveRecord::Base
  belongs_to :brand
  belongs_to :organization  
end
