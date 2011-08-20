require 'spec_helper'

describe TextSession do
  before do
    @text_session = Factory(:text_session)
  end
  
  context 'has relationships' do
    it 'histories' do
      @text_session.respond_to?(:text_histories).should be_true
    end
    it 'chatter' do
      @text_session.respond_to?(:chatter).should be_true
    end
    it 'brand' do
      @text_session.respond_to?(:brand).should be_true
    end    
    
  end
    
end