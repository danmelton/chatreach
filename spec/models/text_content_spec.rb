require 'spec_helper'

describe TextContent do
  before do
    @text_content = Factory(:text_content)
  end
  context 'validations' do
    it 'uniqueness' do
      attr = Factory.attributes_for(:text_content)
      TextContent.create!(attr)
      @invalid_brand = TextContent.create(attr)
      @invalid_brand.should_not be_valid
    end  
      
    context 'responds' do
      it 'to tags' do
        @text_content.respond_to?(:tag).should be_true
      end
    end
  end
end