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
    
  end
  
  context 'special calls' do
    it 'brand setting methods' do
      @brand.respond_to?(:welcome).should be_true
      @brand.respond_to?(:info_not_found).should be_true      
      @brand.respond_to?(:clinic_not_found).should be_true      
      @brand.respond_to?(:provider).should be_true      
      @brand.respond_to?(:phone_number).should be_true      
      @brand.respond_to?(:provider_api_key).should be_true      
      @brand.respond_to?(:provider_secret_key).should be_true      
    end
    
    it 'should build brand settings on create' do
      @brand.brand_settings.size.should == 7
      @brand.welcome.setting.should == nil
    end
    
  end
  
  context 'destroy' do
    it 'deletes BrandAdmins' do
      lambda {@brand.destroy}.should change(BrandAdmin, :count).by(-2)
    end
    it 'deletes brand_settings' do
      lambda {@brand.destroy}.should change(BrandSetting, :count).by(-7)
    end
  end
  
  
end