class Category < ActiveRecord::Base
  has_many :brand_categories
  has_many :brands, :through => :brand_categories
  has_many :text_contents
  has_many :text_histories
  has_many :tag_typos, :dependent => :destroy
  validates_presence_of :name
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  after_save :save_tag_typos

  default_scope :order => 'categories.name ASC'

  before_save :downcase_name
  
  def downcase_name
    name = self.name
    self.name = name.downcase
  end
  
  def save_tag_typos
    generate_typos.each do |typo_name|
      self.tag_typos.find_or_create_by_typo(typo_name)
    end
  end

  def generate_typos
    typo_array = Typo.new(name).all
  end
end
