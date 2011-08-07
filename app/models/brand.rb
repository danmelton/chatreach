class Brand < ActiveRecord::Base
    has_many :account_brands, :dependent => :destroy  
    has_many :accounts, :through => :account_brands
    has_many :brand_tags
    has_many :tags, :through => :brand_tags    
    has_many :article_brands
    has_many :articles, :through => :article_brands
    has_many :brand_categories
    has_many :categories, :through => :brand_categories
    has_many :brand_videos
    has_many :videos, :through => :brand_videos
    has_many :account_organizations
    has_many :referrals    
    has_many :brand_settings
    has_many :conversations 
    has_many :text_contents
    has_many :text_sessions
    has_many :feeds
    has_many :feed_sources
    has_many :profiles
    has_many :faqs
    has_many :helps
    has_many :blogs
    has_many :keywords
    has_many :brand_admins
    has_many :admins, :through => :brand_admins, :source => :user    
end
