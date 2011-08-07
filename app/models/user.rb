class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :account
  has_one :uprofile, :dependent => :delete
  has_many :articles
  has_many :referrals
  has_many :conversations
  has_many :text_contents
  has_many :faqs
  has_many :helps
  has_many :blogs
  has_many :brand_admins
  has_many :brands, :through => :brand_admins
  attr_accessible :account, :admin, :inactive

  def name
    if uprofile.nil?
      self.email.to_s
    else  
      self.uprofile.first_name.to_s + " " + self.uprofile.last_name.to_s
    end
  end
end
