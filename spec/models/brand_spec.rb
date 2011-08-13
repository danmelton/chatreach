require 'spec_helper'

describe Brand do
  before do
    @brand = Factory(:brand)
  end
  context 'validates' do
    it 'uniqueness of name' do
      attr = Factory.attributes_for(:brand)
      Brand.create!(attr)
      @invalid_brand = Brand.create(attr)
      @invalid_brand.should_not be_valid
    end  
  end
  context 'has many' do
    it 'admins' do
      @brand.respond_to?(:admins).should be_true
      @brand.admins.size.should == 2
    end
  end
  
end