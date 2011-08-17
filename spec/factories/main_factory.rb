
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.password "something"
  u.admin false
end

Factory.define :admin_user, :parent => :user do |u|
  u.admin true
end


Factory.define :brand do |b|
  b.name { Faker::Lorem.words(1)[0] }
  b.admins { [Factory(:user), Factory(:user)]}
  b.categories {[Factory(:category), Factory(:category)]}
end

Factory.define :category do |c|
  c.name { Faker::Lorem.words(1)[0] + rand(100).to_s }
end

Factory.define :brand_setting do |b|
  b.brand {Factory(:brand)}
  b.name "welcome"
  b.setting {Faker::Lorem.sentence[0..140]}
end

Factory.define :organization, do |o|
  o.name {Faker::Company.name}
  o.address "1000 S Van Ness"
  o.city "San Francisco"
  o.state "CA"
  o.zip "94110"
  o.country "USA"
  o.phone {Faker::PhoneNumber.phone_number}
  o.sms_about {Faker::Lorem.sentence}
  o.tag_list "#{Faker::Lorem.words(1)[0]},#{Faker::Lorem.words(1)[0]}"
end

Factory.define :text_content do |t|
  t.brand {Factory(:brand)}
  t.tag {ActsAsTaggableOn::Tag.create(:name => Faker::Lorem.words(1)[0])}
  t.category [Factory(:category)]
  t.response {Faker::Lorem.sentence}
end


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
