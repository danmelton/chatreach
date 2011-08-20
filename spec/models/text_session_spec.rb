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
  
  context "time scoped sessions" do
    
    it 'returns a session for today' do
      TextSession.today.should == [@text_session]
    end
    
    it 'returns a new session as the last one was yesterday' do
      Timecop.freeze(Date.today - 30) do
        @text_session2 = Factory(:text_session)
        TextSession.today.size.should == 1
        TextSession.count.should == 2        
      end
        TextSession.today.size.should == 1      
    end
    
  end
    
end