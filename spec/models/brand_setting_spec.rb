require 'spec_helper'

describe BrandSetting do
  before do
    @brandsetting = Factory(:brand_setting)
  end
  context 'validations' do
    it 'uniqueness of name scoped to brand' do
      attr = Factory.attributes_for(:brand_setting)
      BrandSetting.create!(attr)
      @invalid_brand_setting = BrandSetting.create(attr)
      @invalid_brand_setting.should_not be_valid
    end  
  end
  
  context 'has one' do
    it 'brand' do
      @brandsetting.respond_to?(:brand).should be_true
    end    
  end
  
end