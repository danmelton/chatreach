require 'spec_helper'

describe TextContent do
  before do
    @text_content = Factory(:text_content)
  end
  context 'validations' do
    it 'uniqueness of brand scoped by category and tag' do
      attr = Factory.attributes_for(:text_content)
      TextContent.create!(attr)
      @invalid_text_content = TextContent.create(attr)
      @invalid_text_content.should_not be_valid
    end    
  end
  
  context 'relationships' do
    it 'brands' do
      @text_content.respond_to?(:brand).should be_true
    end
    it 'categories' do
      @text_content.respond_to?(:category).should be_true
    end
    it 'tags' do
      @text_content.respond_to?(:tag).should be_true
    end
    it 'text histories' do
      @text_content.respond_to?(:text_histories).should be_true
    end
  end
  
end