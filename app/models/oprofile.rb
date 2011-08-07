class Oprofile < ActiveRecord::Base
  has_many :referrals, :as => :rcontent
  has_many :account_organizations
  has_many :accounts, :through => :account_organizations
  acts_as_taggable_on :sext
  belongs_to :owner, :class_name => 'Account', :foreign_key => 'account_id'
  belongs_to :custodian, :class_name => 'Account', :foreign_key => 'custodial_id'
  before_save :geocode
  
  named_scope :unlinked, lambda { |oprofile_ids| {:conditions => ['oprofiles.id NOT IN (' + oprofile_ids + ')']}}
  named_scope :linked, lambda { |oprofile_ids| {:conditions => ['oprofiles.id IN (' + oprofile_ids + ')']}}
  named_scope :available, lambda { |account, brand| {:include => :account_organizations, :conditions => ['account_organizations.account_id = ? and account_organizations.brand_id= ?', account, brand]}}
  named_scope :with_brand, lambda { |brand| {  :include => :account_organizations, :conditions => ['account_organizations.brand_id = ?', brand] } }
  named_scope :m_circle, lambda { |lon, lat, m| {  :select => ['oprofiles.*, round((((acos(sin(('+lon.to_s+'*pi()/180)) * sin((x(oprofiles.geom)*pi()/180)) + cos(('+lon.to_s+'*pi()/180)) * cos((x(oprofiles.geom)*pi()/180)) * cos((('+lat.to_s+'- y(oprofiles.geom))*pi()/180))))*180/pi())*60*1.1515),2) as distance'],
     :conditions => ['round((((acos(sin((?*pi()/180)) * sin((x(oprofiles.geom)*pi()/180)) + cos((?*pi()/180)) * cos((x(oprofiles.geom)*pi()/180)) * cos(((?- y(oprofiles.geom))*pi()/180))))*180/pi())*60*1.1515),2) <= ?', lon, lon, lat, m] ,
     :order => ['round((((acos(sin(('+lon.to_s+'*pi()/180)) * sin((x(oprofiles.geom)*pi()/180)) + cos(('+lon.to_s+'*pi()/180)) * cos((x(oprofiles.geom)*pi()/180)) * cos((('+lat.to_s+'- y(oprofiles.geom))*pi()/180))))*180/pi())*60*1.1515),2) ASC'] } }   

  define_index do
     indexes about
     indexes name
     indexes address
     indexes sms_about
  end
       
  def geocode
      if !address.blank?
      address = self.address + " " +self.city + ", " + self.state + " "+ self.zip.to_s
      address_geo = "http://sex.chatreach.com/geo?address=#{address}"
      xml_doc = Nokogiri::HTML(open(URI.escape(address_geo)))
      self.geom = Point.from_x_y(xml_doc.search('longitude')[0].inner_text, xml_doc.search('latitude')[0].inner_text)
      end
  end
  
  def full_address
    "#{self.address}</br>#{self.city}, #{self.state} #{self.zip}"
  end   
  
  def to_url
    "#{id}/" + "#{name}".downcase.gsub(/\W+/, "-").gsub(/^[-]+|[-]$/,"").strip
  end 
  
  def state_name
    state_abbr[self.state]
  end 
  
  private
  
  def state_abbr
       {
         'AL' => 'Alabama',
         'AK' => 'Alaska',
         'AS' => 'America Samoa',
         'AZ' => 'Arizona',
         'AR' => 'Arkansas',
         'CA' => 'California',
         'CO' => 'Colorado',
         'CT' => 'Connecticut',
         'DE' => 'Delaware',
         'DC' => 'District of Columbia',
         'FM' => 'Micronesia1',
         'FL' => 'Florida',
         'GA' => 'Georgia',
         'GU' => 'Guam',
         'HI' => 'Hawaii',
         'ID' => 'Idaho',
         'IL' => 'Illinois',
         'IN' => 'Indiana',
         'IA' => 'Iowa',
         'KS' => 'Kansas',
         'KY' => 'Kentucky',
         'LA' => 'Louisiana',
         'ME' => 'Maine',
         'MH' => 'Islands1',
         'MD' => 'Maryland',
         'MA' => 'Massachusetts',
         'MI' => 'Michigan',
         'MN' => 'Minnesota',
         'MS' => 'Mississippi',
         'MO' => 'Missouri',
         'MT' => 'Montana',
         'NE' => 'Nebraska',
         'NV' => 'Nevada',
         'NH' => 'New Hampshire',
         'NJ' => 'New Jersey',
         'NM' => 'New Mexico',
         'NY' => 'New York',
         'NC' => 'North Carolina',
         'ND' => 'North Dakota',
         'OH' => 'Ohio',
         'OK' => 'Oklahoma',
         'OR' => 'Oregon',
         'PW' => 'Palau',
         'PA' => 'Pennsylvania',
         'PR' => 'Puerto Rico',
         'RI' => 'Rhode Island',
         'SC' => 'South Carolina',
         'SD' => 'South Dakota',
         'TN' => 'Tennessee',
         'TX' => 'Texas',
         'UT' => 'Utah',
         'VT' => 'Vermont',
         'VI' => 'Virgin Island',
         'VA' => 'Virginia',
         'WA' => 'Washington',
         'WV' => 'West Virginia',
         'WI' => 'Wisconsin',
         'WY' => 'Wyoming'
       }
     end
  
end
