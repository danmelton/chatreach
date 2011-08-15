require 'factory_girl'
require 'faker'
require 'factory_girl_rails'

if Rails.env!='production'
  stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
    with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => fixture('google_maps'), :headers => {})
    
  puts "Creating Admin"
  admin = Factory(:admin_user)
  puts "Creating 5 Users with password something"
  5.times { |x| u = Factory(:user); puts "   " + u.email }
  users = User.where(:admin => false)
  
  puts "Creating Brands"
  brands = 5.times { |x| Factory(:brand, :admins => [users[rand(4)]]) }
  
  puts "Creating Categories"
  25.times {|x| Category.create(:name => Faker::Lorem.words(2).join(" "))}
  
  puts "Adding Categories to Brands"
  Brand.all.each {|x| x.categories << Category.all.shuffle[0..5]}
  
end