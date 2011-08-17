class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  has_many :text_contents

  default_scope :order => 'categories.name ASC'

  before_save :downcase_name
  
  def downcase_name
    name = self.name
    self.name = name.downcase
  end
end
