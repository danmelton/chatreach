class CategoryText < ActiveRecord::Base
  belongs_to :category
  belongs_to :text_content
end
