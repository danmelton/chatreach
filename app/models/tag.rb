class Tag < ActiveRecord::Base
  has_many :text_contents
end