class Category < ActiveRecord::Base
  has_many :brand_categories
  has_many :brands, :through => :brand_categories
  has_many :article_categories
  has_many :articles, :through => :article_categories
  has_many :category_texts
  has_many :text_contents, :through => :category_texts
  has_many :text_histories
  belongs_to :account
  validates_presence_of :name
  default_scope :order => 'categories.name ASC'
  named_scope :brand, lambda { |brand| {  :include => :brands, :conditions => ['brands.id = ?', brand] } }
  named_scope :account_is, lambda { |account| {  :conditions => ['categories.account_id = "1" or categories.account_id = ?', account] } }
end
