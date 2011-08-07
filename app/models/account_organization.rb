class AccountOrganization < ActiveRecord::Base
  belongs_to :account
  belongs_to :oprofile
  belongs_to :brand
  
  named_scope :with_brand, lambda { |brand| { :include => :oprofile, :conditions => ['account_organizations.brand_id = ?', brand] } }

end
