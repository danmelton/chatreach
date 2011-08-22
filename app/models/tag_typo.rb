class TagTypo < ActiveRecord::Base
  belongs_to :tag
  belongs_to :category
  
end
