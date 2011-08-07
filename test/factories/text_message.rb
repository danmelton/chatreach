Factory.sequence :tag_name do |n|
  "hiv#{n}"
end

Factory.define :tag do |tag|
  tag.name { Factory.next :tag_name }
end

Factory.define :text_content do |tc|
  tc.brand  {Factory(:brand)}
  tc.response "Something funny"
  tc.user {Factory(:user_confirmed)}
  tc.published "1"
  tc.sext_list {Factory(:tag)}
  tc.categories {[Factory(:category)]}
end

Factory.sequence :cat_name do |n|
  "something#{n}"
end

Factory.define :category do |c|
  c.name {Factory.next :cat_name}
end

Factory.sequence :keyword do |n|
  "sext#{n}"
end

Factory.define :sext, :parent => :brand_setting do |setting|
  setting.name "keyword"
  setting.setting { Factory.next :bname }
end

Factory.define :sext_description, :parent => :brand_setting do |setting|
  setting.name "description"
  setting.setting "Welcome to the Sext Line"
end

Factory.sequence :sessionID do |n|
    "34234235I345664A56#{n}"
end

Factory.define :text_session do |ses|
  ses.session {Factory.next :sessionID }
  ses.chatter {Factory(:chatter)}
  ses.brand {Factory(:brand)}
  ses.phone {Factory.next :phone}
  ses.account {Factory(:account)}
end

Factory.define :carrier do |car|
  car.name "default"
  car.carrierid "9999"
end

Factory.define :text_history do |th|
  th.text_session {Factory(:session)}
  th.tag {Factory(:tag, :name => "something")}
  th.text "something tag response"
  th.response "something fun"
end

Factory.define :text_history_category, :parent => :text_history do |th|
  th.text_session {Factory(:session)}
  th.tag {Factory(:tag, :name => "something")}
  th.text "something category1"
  th.response "something category1 fun"
end