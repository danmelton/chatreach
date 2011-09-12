class Chatter < ActiveRecord::Base
  validates_presence_of :phone, :on => :create, :message => "can't be blank"
  validates_uniqueness_of :phone, :on => :create, :message => "must be unique"
  has_many :text_sessions, :dependent => :destroy
  has_many :brands, :through => :text_sessions
  
  # TODO MD5 or other encryption
  # before_validation :convert_phone
  # 
  # def find_by_phone(phone)
  #   Chatter.where(:phone => Digest::MD5.new(phone).to_s)
  # end
  # 
  # def convert_phone
  #   new_phone = Digest::MD5.new(self.phone).to_s
  #   puts new_phone
  #   self.phone = new_phone
  # end
end
