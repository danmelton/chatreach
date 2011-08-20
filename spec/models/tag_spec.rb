require 'spec_helper'


describe Tag do
  before do
    @tag = Factory(:tag)
  end
  
  context 'has relationships' do
    it 'text contents' do
      @tag.respond_to?(:text_contents).should be_true
    end
    it 'text histories' do
      @tag.respond_to?(:text_histories).should be_true
    end
    it 'tag typos' do
      @tag.respond_to?(:tag_typos).should be_true
      @tag.tag_typos.blank?.should be_false
    end
  end
  
  context 'special methods' do
    
    it 'generates tag typos' do
      tag = Factory(:tag, :name => "love")
      typos = tag.generate_typos
      typos.class.should == Array
      typos.size.should == 28
      typos.include?("olve").should be_true
    end
  end
  
end