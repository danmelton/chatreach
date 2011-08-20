class TextContent < ActiveRecord::Base
  belongs_to :brand, :class_name => "Brand", :foreign_key => "brand_id"
  belongs_to :tag, :class_name => "Tag", :foreign_key => "tag_id"
  belongs_to :category, :class_name => "Category", :foreign_key => "category_id"
  
  validates_presence_of :category, :brand, :response
  validates_uniqueness_of :tag_id, :scope => [:category_id, :brand_id], :message => "Tag and Action combinaation must be unique"
end
