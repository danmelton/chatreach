require 'spec_helper'

describe BrandSetting do
  before do
    @brand = Factory(:brand)
  end
  context 'validations' do
    it 'uniqueness of name scoped to brand' do
      attr = Factory.attributes_for(:brand_setting, :brand => @brand)
      @invalid_brand_setting = BrandSetting.create(attr)
      @invalid_brand_setting.should_not be_valid
    end  
  end
  
  context 'has one' do
    it 'brand' do
      BrandSetting.first.respond_to?(:brand).should be_true
    end    
  end
  
end