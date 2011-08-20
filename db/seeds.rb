require 'factory_girl'
require 'faker'
require 'factory_girl_rails'
require 'webmock'
require 'rspec/rails'

if Rails.env!='production'

  puts "Creating Admin"
  admin = Factory(:admin_user)

  puts "Creating 5 Users with password something"
  5.times { |x| u = Factory(:user); puts "   " + u.email }
  users = User.where(:admin => false)
  
  puts "Creating Brands"
  brands = 3.times { |x| Factory(:brand, :admins => [users[rand(4)]]) }
  
  puts "Creating Categories"
  25.times {|x| Category.create(:name => Faker::Lorem.words(2).join(" "))}
  
  puts "Adding Categories to Brands"
  Brand.all.each {|x| x.categories << Category.all.shuffle[0..5]}
  
  puts "Adding Tags"
  25.times {|x| ActsAsTaggableOn::Tag.create(:name => Faker::Lorem.words(1)[0] + rand(100).to_s)}  

  WebMock.stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
  with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body =>   File.new("#{::Rails.root}/spec/fake" + '/' + 'google_maps'), :headers => {})

  puts "adding organizations"
  20.times { |x| Factory(:organization, :tag_list => ActsAsTaggableOn::Tag.all.shuffle[0..5])}      

  puts "adding content"  
  Brand.all.each do |brand|
    puts "  for #{brand.name}"
    Category.all.each do |category|
      Tag.all.each do |tag|
        Factory(:text_content, :brand => brand, :category => category, :tag => tag)
      end
    end
  end
  
  
end