class Chatter < ActiveRecord::Base
  has_many :uprofiles
  has_many :text_sessions
  has_one :chatter_profile
end
