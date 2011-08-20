require 'spec_helper'

describe TextSession do
  before do
    @text_session = Factory(:text_session)
  end
  context 'validations' do
    it 'uniqueness of name' do
      attr = Factory.attributes_for(:text_session)
      TextSession.create!(attr)
      @invalid_text_session = TextSession.create(attr)
      @invalid_text_session.should_not be_valid
    end  
  
    it 'downcases before saving' do
      attr = Factory.attributes_for(:text_session, :name => "NOT")
      text_session = TextSession.create!(attr)
      text_session.name.should == "not"
      text_session.update_attributes(:name => "NOT")
      text_session.name.should == "not"      
    end
  
  end
  
  context 'has many' do
    it 'admins' do
      @text_session.respond_to?(:admins).should be_true
      @text_session.admins.size.should == 2
    end
    it 'categories' do
      @text_session.respond_to?(:categories).should be_true
      @text_session.categories.size.should == 2
    end
    it 'text_session settings' do
      @text_session.respond_to?(:text_session_settings).should be_true
    end
    it 'organizations' do
      @text_session.respond_to?(:organizations).should be_true
    end
    it 'text_contents' do
      @text_session.respond_to?(:text_contents).should be_true
    end
    
  end
    
end