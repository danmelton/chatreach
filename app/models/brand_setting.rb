class BrandSetting < ActiveRecord::Base
  belongs_to :account
  belongs_to :brand
  
  named_scope :with_brand, lambda { |brand| {  :conditions => ['brand_settings.brand_id = ?', brand] } }
  named_scope :with_account, lambda { |account| {  :conditions => ['brand_settings.account_id = ?', account] } }  
  named_scope :with_name, lambda { |name| {  :conditions => ['brand_settings.name = ?', name] } }    
  named_scope :with_domain, lambda { |domain| {  :conditions => ["brand_settings.name = 'domain' and brand_settings.setting = ?", domain] } }
  named_scope :domains, lambda { {  :conditions => ["brand_settings.name = 'domain'"] } }

  def self.with_keyword(name)
     find(:all, :conditions => ["brand_settings.name='keyword' and LOWER(setting) = ?", name.downcase])
  end
  
  def self.all_settings(account, brand)
    find(:all, :conditions => ["brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.with_account_and_brand(account, brand)
     find(:all, :conditions => ["brand_settings.name='keyword' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.description_for_keyword(account, brand)
     find(:all, :conditions => ["brand_settings.name='description' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.description_for_not_found(account, brand)
     find(:all, :conditions => ["brand_settings.name='clinic not found' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.description_for_info_not_found(account, brand)
     find(:all, :conditions => ["brand_settings.name='info not found' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end

  def self.logo(brand)
     find(:all, :conditions => ["brand_settings.name='logo' and brand_settings.brand_id = ?", brand])
  end
  
  def self.contact(account, brand)
     find(:all, :conditions => ["brand_settings.name='contact' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.color(account, brand)
     find(:all, :conditions => ["brand_settings.name='color' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.info(account, brand)
     find(:all, :conditions => ["brand_settings.name='info' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.disclaimer(account, brand)
     find(:all, :conditions => ["brand_settings.name='disclaimer' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.center(account, brand)
     find(:all, :conditions => ["brand_settings.name='center' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.zoom(account, brand)
     find(:all, :conditions => ["brand_settings.name='zoom' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
  def self.google(account, brand)
     find(:all, :conditions => ["brand_settings.name='google' and brand_settings.brand_id = ? and brand_settings.account_id = ?", brand, account])
  end
  
end
