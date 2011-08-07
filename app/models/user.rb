class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

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
