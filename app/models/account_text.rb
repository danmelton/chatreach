class AccountText < ActiveRecord::Base
  belongs_to :text_content
  belongs_to :account
end
