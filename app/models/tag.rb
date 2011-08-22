class Tag < ActiveRecord::Base
  scope :alpha, :order => "name ASC"
  has_many :text_contents
  has_many :text_histories
  has_many :tag_typos, :dependent => :destroy
  after_save :save_tag_typos
  
  def save_tag_typos
    generate_typos.each do |typo_name|
      self.tag_typos.find_or_create_by_typo(typo_name)
    end
  end

  def generate_typos
    typo_array = Typo.new(name).all
  end
    
end
