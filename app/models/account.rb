class Account < ActiveRecord::Base
  has_many :account_brands, :dependent => :destroy
  has_many :users
  has_many :brands, :through => :account_brands  
  has_many :account_articles
  has_many :articles, :through => :account_articles
  has_many :account_organizations
  has_many :oprofiles, :through => :account_organizations
  has_many :programs, :class_name => 'Oprofile', :foreign_key => 'account_id'
  has_many :custodials, :class_name => 'Oprofile', :foreign_key => 'custodial_id'
  has_many :account_texts
  has_many :text_contents, :through => :account_texts
  has_many :categories
  has_many :brand_settings
  has_many :conversations
  has_many :text_sessions
  has_many :profiles
  
  def to_url
    "#{id}/" + "#{name}".downcase.gsub(/\W+/, "-").gsub(/^[-]+|[-]$/,"").strip
  end
  
end
