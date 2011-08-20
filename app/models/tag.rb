class Tag < ActiveRecord::Base
    scope :alpha, :order => "name ASC"
    has_many :text_contents
end
