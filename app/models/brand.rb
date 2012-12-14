# Brands are unique names required to start sessions via texts.
# They have settings as well and only can be edited by administrators
class Brand < ActiveRecord::Base
  has_many :brand_admins, :dependent => :destroy
  has_many :admins, :through => :brand_admins, :source => :user
  has_many :brand_organizations, :dependent => :destroy
  has_many :organizations, :through => :brand_organizations  
  has_many :categories
  has_many :text_contents, :dependent => :destroy  
  has_many :brand_settings, :dependent => :destroy
  has_many :text_sessions, :dependent => :destroy  
  before_save :downcase_name
  after_create :build_brand_settings
  accepts_nested_attributes_for :brand_settings
  
  def downcase_name
    name = self.name
    self.name = name.downcase
  end
  
  def welcome
    brand_settings.where(:name => "welcome").first
  end
  
  def organization_not_found
    brand_settings.where(:name => "organization_not_found").first    
  end
  
  def info_not_found
    brand_settings.where(:name => "info_not_found").first    
  end
  
  def distance_for_organization
    brand_settings.where(:name => "distance_for_organization").first    
  end
  
  def provider
    brand_settings.where(:name => "provider").first    
  end
  
  def phone_number
    brand_settings.where(:name => "phone_number").first    
  end
  
  def list_tags
    brand_settings.where(:name => "list_tags").first    
  end
  
  def build_brand_settings
    ["welcome","organization_not_found","info_not_found", "distance_for_organization", "provider","phone_number", "list_tags"].each do |setting|
      brand_settings.create(:name => setting)
    end
    brand_settings
  end
  
  # Copies the text contents from a brand to this one
  def copy_text_content_from(brand)
    if !brand.nil?
      brand.text_contents.each do |text|
        tc = text.clone
        tc.brand_id = self.id
        tc.save
      end
    end
  end
    
end
