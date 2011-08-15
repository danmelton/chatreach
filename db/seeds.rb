require 'factory_girl'
require 'faker'
require 'factory_girl_rails'

if Rails.env!='production'
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