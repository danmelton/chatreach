class TextContent < ActiveRecord::Base
  belongs_to :brand
  belongs_to :user
  has_many :category_texts
  has_many :categories, :through => :category_texts
  named_scope :published, lambda {{:conditions => ['text_contents.published = ?', true]}}
  named_scope :unpublished, lambda {{:conditions => ['text_contents.published = ?', false]}}  
  named_scope :with_brand, lambda { |brand| {  :conditions => ['text_contents.brand_id = ?', brand] } }
  named_scope :belongs_to, lambda { |account| { :include => :accounts, :conditions => ['accounts.id = ?', account] } }
  named_scope :with_tagging, lambda { |tag| { :include => :taggings, :conditions => ['taggings.id = ?', tag] } }
  named_scope :with_category, lambda { |cat| { :include => :categories, :conditions => ['categories.id = ?', cat] } }  
  acts_as_taggable_on :sext
  
  

end
