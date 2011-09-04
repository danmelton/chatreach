require 'spec_helper'

describe Brand do
  before do
    @brand = Factory(:brand)
  end
  context 'validations' do
    it 'uniqueness of name' do
      attr = Factory.attributes_for(:brand)
      Brand.create!(attr)
      @invalid_brand = Brand.create(attr)
      @invalid_brand.should_not be_valid
    end  
  
    it 'downcases before saving' do
      attr = Factory.attributes_for(:brand, :name => "NOT")
      brand = Brand.create!(attr)
      brand.name.should == "not"
      brand.update_attributes(:name => "NOT")
      brand.name.should == "not"      
    end
  
  end
  
  context 'has many' do
    it 'admins' do
      @brand.respond_to?(:admins).should be_true
      @brand.admins.size.should == 2
    end
    it 'categories' do
      @brand.respond_to?(:categories).should be_true
      @brand.categories.size.should == 2
    end
    it 'brand settings' do
      @brand.respond_to?(:brand_settings).should be_true
    end
    it 'organizations' do
      @brand.respond_to?(:organizations).should be_true
    end
    it 'text_contents' do
      @brand.respond_to?(:text_contents).should be_true
    end
    
  end
  
  context 'special calls' do
    it 'brand setting methods' do
      @brand.respond_to?(:welcome).should be_true
      @brand.respond_to?(:info_not_found).should be_true      
      @brand.respond_to?(:organization_not_found).should be_true      
      @brand.respond_to?(:distance_for_organization).should be_true            
      @brand.respond_to?(:provider).should be_true      
      @brand.respond_to?(:phone_number).should be_true      
      @brand.respond_to?(:provider_api_key).should be_true      
      @brand.respond_to?(:provider_secret_key).should be_true      
    end
    
    it 'should build brand settings on create' do
      @brand.brand_settings.size.should == 8
      @brand.welcome.setting.should == nil
    end
    
  end
  
  context 'destroy' do
    before do
      stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => fixture('google_maps'), :headers => {})
    end
    it 'deletes BrandAdmins' do
      lambda {@brand.destroy}.should change(BrandAdmin, :count).by(-2)
    end
    it 'deletes brand_settings' do
      lambda {@brand.destroy}.should change(BrandSetting, :count).by(-8)
    end
    it 'deletes brand_organizations' do
      @brand.organizations << Factory(:organization)
      lambda {@brand.destroy}.should change(BrandOrganization, :count).by(-1)
    end
    it 'deletes text contents' do
      Factory(:text_content, :brand => @brand)
      lambda {@brand.destroy}.should change(TextContent, :count).by(-1)
    end
    
    it 'deletes text sessions' do
      Factory(:text_session, :brand => @brand)
      lambda {@brand.destroy}.should change(TextSession, :count).by(-1)
    end
    
  end
  
  context 'it copies a previous brand content' do
    it 'copies all text content' do
      5.times {Factory(:text_content, :brand => @brand)}
      new_brand = Factory(:brand)
      new_brand.copy_text_content_from(@brand)
      new_brand.text_contents.size.should == 5
    end
    
    it 'doesnt fail out on duplicates or other problems' do
      2.times {Factory(:text_content, :brand => @brand)}
      new_brand = Factory(:brand)
      new_brand.copy_text_content_from(@brand)
      new_brand.text_contents.size.should == 2
      new_brand.copy_text_content_from(@brand)
      new_brand.text_contents.size.should == 2      
    end
  end
  

  
end