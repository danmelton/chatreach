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
  end
  
  context 'destroy' do
    it 'deletes dependents' do
      lambda {@brand.destroy}.should change(BrandAdmin, :count).by(-2)
    end
  end
  
end