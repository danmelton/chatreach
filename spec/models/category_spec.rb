require 'spec_helper'

describe Category do
  before do
    @category = Factory(:category)
  end
  context 'validations' do
    it 'uniqueness of name' do
      attr = Factory.attributes_for(:category)
      Category.create!(attr)
      @invalid_brand = Category.create(attr)
      @invalid_brand.should_not be_valid
    end  
  
    it 'downcases before saving' do
      attr = Factory.attributes_for(:category, :name => "NOT")
      cat = Category.create!(attr)
      cat.name.should == "not"
      cat.update_attributes(:name => "NOT")
      cat.name.should == "not"      
    end
    
    context 'has many' do
      it 'admins' do
        @category.respond_to?(:brands).should be_true
      end
    end
  end
end