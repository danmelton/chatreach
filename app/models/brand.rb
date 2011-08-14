# Brands are unique names required to start sessions via texts.
# They have settings as well and only can be edited by administrators
class Brand < ActiveRecord::Base
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  has_many :brand_admins, :dependent => :destroy
  has_many :admins, :through => :brand_admins, :source => :user
  has_many :categories
  has_many :brand_settings, :dependent => :destroy
  before_save :downcase_name
  
  def downcase_name
    name = self.name
    self.name = name.downcase
  end
  
  def welcome
    brand_settings.where(:name => "welcome").first
  end
  
  def clinic_not_found
    brand_settings.where(:name => "clinic_not_found").first    
  end
  
  def info_not_found
    brand_settings.where(:name => "info_not_found").first    
  end
  
  def provider
    brand_settings.where(:name => "provider").first    
  end
  
  def phone_number
    brand_settings.where(:name => "phone_number").first    
  end
  
  def provider_api_key
    brand_settings.where(:name => "api_key").first        
  end
  
  def provider_secret_key
    brand_settings.where(:name => "provider_secret_key").first        
  end
  
  def build_brand_settings
    ["welcome","clinic_not_found","info_not_found","provider","phone_number","api_key","provider_secret_key" ].each do |setting|
      brand_settings.create(:name => setting)
    end
    brand_settings
  end
  
  
  
end
