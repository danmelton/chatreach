class Organization < ActiveRecord::Base
  has_many :brand_organizations, :dependent => :destroy
  has_many :brands, :through => :brand_organizations
  acts_as_taggable_on :tag
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  validates_presence_of :name, :address, :city, :state, :zip, :sms_about
  geocoded_by :full_street_address
  after_validation :geocode 
  
  scope :m_circle, lambda { |lon, lat, m| {  :select => ['oprofiles.*, round((((acos(sin(('+lon.to_s+'*pi()/180)) * sin((x(oprofiles.geom)*pi()/180)) + cos(('+lon.to_s+'*pi()/180)) * cos((x(oprofiles.geom)*pi()/180)) * cos((('+lat.to_s+'- y(oprofiles.geom))*pi()/180))))*180/pi())*60*1.1515),2) as distance'],
     :conditions => ['round((((acos(sin((?*pi()/180)) * sin((x(oprofiles.geom)*pi()/180)) + cos((?*pi()/180)) * cos((x(oprofiles.geom)*pi()/180)) * cos(((?- y(oprofiles.geom))*pi()/180))))*180/pi())*60*1.1515),2) <= ?', lon, lon, lat, m] ,
     :order => ['round((((acos(sin(('+lon.to_s+'*pi()/180)) * sin((x(oprofiles.geom)*pi()/180)) + cos(('+lon.to_s+'*pi()/180)) * cos((x(oprofiles.geom)*pi()/180)) * cos((('+lat.to_s+'- y(oprofiles.geom))*pi()/180))))*180/pi())*60*1.1515),2) ASC'] } }   
  
  def full_street_address
    [address, city, state, zip, country].compact.join(', ')
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
