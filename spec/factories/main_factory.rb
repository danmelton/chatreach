#User Factories
Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.password "something"
  u.admin false
  # u.uprofile {Factory(:uprofile)}
end

Factory.define :admin_user,:parent => :user do |u|
  u.admin true
end
# 
# 
# Factory.define :organization, :parent => :account do |org|
#   org.name "Something Fun"
#   org.users {[Factory(:user),Factory(:user)]}
# end
# 
# #Account Factories
# Factory.define :account do |account|
#   account.name "My Organization"
# end
# 
# Factory.sequence :bname do |n|
#   "brand#{n}"
# end
# 
# #Brand Factories
# Factory.define :brand do |brand|
#   brand.name { Factory.next :bname }
# end
# 
# # Chatter Factories
# 
# Factory.define :chatter do |chatter|
#   chatter.chatter_profile {Factory(:chatter_profile)}
# end
# 
# Factory.sequence :phone do |n|
#   "913871583#{n}"
# end
# 
# Factory.define :oprofile do |o|
#   o.address "613 Sandusky Ave"
#   o.city "Kansas City"
#   o.state "KS"
#   o.zip "66101"
#   o.owner {Factory(:account)}
#   o.sms_about "something"
# end
# 
# Factory.define :uprofile do |o|
#   o.address "613 Sandusky Ave"
#   o.city "Kansas City"
#   o.state "KS"
#   o.zip "66101"
#   o.first_name "Dan"
#   o.last_name "Melton"  
# end
# 
# Factory.define :chatter_profile do |profile|
#   profile.birthday "1/12/1980"
#   profile.age "29"
#   profile.gender "M"
#   profile.phone {Factory.next :phone}
#   profile.zipcode "66101"
#   profile.state "KS"
#   profile.country "USA"
# end
# 
# #Brand Settings
# Factory.define :brand_setting do |setting|
#   setting.brand {Factory(:brand)}
#   setting.name "keyword"
#   setting.setting { Factory.next :bname }
#   setting.account {Factory(:account)}
# end
# 
# Factory.define :account_organization do |acc|
#   acc.account {Factory(:account)}
#   acc.oprofile {Factory(:oprofile)}
#   acc.brand {Factory(:brand)}
# end
