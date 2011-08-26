require 'spec_helper'

describe TextHistory do
  before do
    @text_history = Factory(:text_history)
  end
  
  context 'has relationships' do
    it 'sessions' do
      @text_history.respond_to?(:text_session).should be_true
    end
    it 'tag' do
      @text_history.respond_to?(:tag).should be_true
    end
    it 'category' do
      @text_history.respond_to?(:category).should be_true
    end    
    it 'text content' do
      @text_history.respond_to?(:text_content).should be_true
    end    
    
  end
    
end