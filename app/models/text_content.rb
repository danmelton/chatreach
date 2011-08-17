class TextContent < ActiveRecord::Base
  belongs_to :brand
  belongs_to :category
  belongs_to :tag, :class_name => ActsAsTaggableOn::Tag
  
  validates_uniqueness_of :category, :scope => :tag
  validates_presence_of :content
  
end
