require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'webmock'
require 'rspec/rails'

if Rails.env!='production'
  
  puts "Making some Fakers!"

  puts "Creating Admin"
  admin = Factory(:admin_user)
  puts "admin:" + admin.email

  puts "Creating 5 Users with password something"
  5.times { |x| u = Factory(:user); puts "   " + u.email }
  users = User.where(:admin => false)
  
  puts "Creating Brands"
  brands = 3.times { |x| Factory(:brand, :admins => [users[rand(4)]]) }
  
  puts "Updating Brand Settings"
  Brand.all.each do |brand|
    brand.welcome.update_attributes(:setting => "welcome")
    brand.info_not_found.update_attributes(:setting => "info not found")
    brand.organization_not_found.update_attributes(:setting => "org not found")
    brand.distance_for_organization.update_attributes(:setting => "20")
    brand.provider.update_attributes(:setting => 'text caster')
  end
  
  puts "Creating Categories"
  10.times {|x| Category.create(:name => Faker::Lorem.words(2).join(" "))}
  
  puts "Adding Categories to Brands"
  Brand.all.each {|x| x.categories << Category.all.shuffle[0..5]}
  
  puts "Adding Tags"
  10.times {|x| Tag.create(:name => Faker::Lorem.words(1)[0] + rand(100).to_s)}  

  WebMock.stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
  with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body =>   File.new("#{::Rails.root}/spec/fake" + '/' + 'google_maps'), :headers => {})

  puts "Adding Organizations"
  10.times { |x| Factory(:organization, :tag_list => ActsAsTaggableOn::Tag.all.shuffle[0..5])}      

  puts "Adding Content"  
  Brand.all.each do |brand|
    puts "  for #{brand.name}"
    Category.all.each do |category|
      Tag.all.each do |tag|
        Factory(:text_content, :brand => brand, :category => category, :tag => tag)
      end
    end
  end
  
  puts "Adding chatters"
  5.times { Factory(:chatter)}
  
  puts "Adding Text Sessions"
  chatter = Chatter.all
  Brand.all.each { |brand|
    5.times {|x| Factory(:text_session,:brand => brand, :chatter => chatter[x])}
  }
  
  
  
end