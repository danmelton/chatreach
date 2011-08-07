class Help < ActiveRecord::Base
  belongs_to :brand
  belongs_to :user
  
  named_scope :with_brand, lambda { |brand| {  :conditions => ['helps.brand_id = ?', brand] } }
  named_scope :recent, lambda { |recent| {:order => "helps.created_at DESC", :limit => recent }}
  named_scope :feature, lambda { |number| {:order => "helps.created_at DESC", :conditions => ['helps.feature = ?', true], :limit => number }}  
  
  def to_url
    "#{id}/" + "#{title}".downcase.gsub(/\W+/, "-").gsub(/^[-]+|[-]$/,"").strip
  end
  
end
