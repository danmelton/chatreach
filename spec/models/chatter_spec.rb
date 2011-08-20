require 'spec_helper'

describe Chatter do
  before do
    @chatter = Factory(:chatter)
  end
  context 'validations' do
    it 'uniqueness of phone' do
      attr = Factory.attributes_for(:chatter)
      Chatter.create!(attr)
      @invalid_chatter = Chatter.create(attr)
      @invalid_chatter.should_not be_valid
    end  
  end
  
  context 'deletes' do
    it 'deletes text sessions' do
      Factory(:text_session, :chatter => @chatter)
      lambda {@chatter.destroy}.should change(TextSession, :count).by(-1)
    end
  end
  
end