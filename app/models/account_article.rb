class AccountArticle < ActiveRecord::Base
  belongs_to :article
  belongs_to :account
end
