class Category < ActiveRecord::Base
  has_many :brand_categories
  has_many :brands, :through => :brand_categories
  has_many :text_contents
  has_many :text_histories
  validates_presence_of :name
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"

  default_scope :order => 'categories.name ASC'

  before_save :downcase_name
  
  def downcase_name
    name = self.name
    self.name = name.downcase
  end
end
