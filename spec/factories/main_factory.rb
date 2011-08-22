 
Factory.define :user do |u|
  u.email { Faker::Internet.email }
  u.password "something"
  u.admin false
end

Factory.define :admin_user, :parent => :user do |u|
  u.admin true
end


Factory.define :brand do |b|
  b.name { Faker::Lorem.words(1)[0] + rand(1000).to_s }
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
  o.name {Faker::Company.name + rand(1000).to_s}
  o.address "1000 S Van Ness"
  o.city "San Francisco"
  o.state "CA"
  o.zip "94110"
  o.country "USA"
  o.phone {Faker::PhoneNumber.phone_number}
  o.sms_about {Faker::Lorem.sentence}
  o.tag_list "#{Faker::Lorem.words(1)[0]},#{Faker::Lorem.words(1)[0]}"
end

Factory.define :tag do |t|
  t.name {Faker::Lorem.words(1)[0] + rand(100).to_s}
end

Factory.define :text_content do |t|
  t.brand {Factory(:brand)}
  t.category {Factory(:category)}
  t.tag {Factory(:tag)}  
  t.response {Faker::Lorem.sentence}
end

Factory.define :chatter do |c|
  c.phone {rand(1000)}
  c.age(rand(12)+10)
  c.gender (["M", "F", "T"].shuffle[0])
  c.city {Faker::Address.city}
  c.zipcode {Faker::Address.zip_code}
  c.country {Faker::Address.country}
  c.state {Faker::Address.state_abbr}
end

Factory.define :text_session do |t|
  t.brand {Factory(:brand)}
  t.chatter {Factory(:chatter)}
  t.session {rand(1000)}
end

Factory.define :text_history do |t|
  t.text_session {Factory(:text_session)}
  t.text_type "Action"
  t.text {Faker::Lorem.sentence}
  t.tag {Factory(:tag)}
  t.category {Factory(:category)}
  t.response {Faker::Lorem.sentence}
end
