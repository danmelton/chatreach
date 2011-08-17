require 'spec_helper'

describe Tag do
  before do
    @tag = Factory(:tag)
  end
  context 'validations' do
    it 'uniqueness of name' do
      attr = Factory.attributes_for(:tag)
      Tag.create!(attr)
      @invalid_brand = Tag.create(attr)
      @invalid_brand.should_not be_valid
    end  
  
    it 'downcases before saving' do
      attr = Factory.attributes_for(:tag, :name => "NOT")
      tag = Tag.create!(attr)
      tag.name.should == "not"
      tag.update_attributes(:name => "NOT")
      tag.name.should == "not"      
    end
    
    context 'has many' do
      it 'admins' do
        @tag.respond_to?(:text_contents).should be_true
      end
    end
  end
end