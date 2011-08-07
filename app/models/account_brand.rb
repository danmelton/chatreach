class AccountBrand < ActiveRecord::Base
  belongs_to :account
  belongs_to :brand
end
