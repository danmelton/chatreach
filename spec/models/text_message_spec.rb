require 'spec_helper'

describe TextMessage do
  
  context "sets chatter" do
    
    it 'finds the chatter' do
      chatter = Factory(:chatter)
      s = TextMessage.new(chatter.phone, "message")
      s.set_chatter
      s.chatter.should == chatter
    end
    
    it 'creates a chatter' do
      lambda {
      s = TextMessage.new(rand(10000), "message")
      s.set_chatter
    }.should change(Chatter, :count).by(1)
    end
    
  end
  
  context "sets brand and session" do
    before do
      @brand = Factory(:brand)
    end
    
    it "should find_brand" do
      s = TextMessage.new(rand(1000), @brand.name)
      s.find_brand == @brand
    end
    
    it "should not find_brand" do
      s = TextMessage.new(rand(1000), 'something')
      s.find_brand == []
    end
    
    it "should set_brand_by_last_session" do
      @session = Factory(:text_session, :brand => @brand)
      s = TextMessage.new(@session.chatter.phone, @brand.name)
      s.set_brand_by_last_session.should == @brand
    end
    
    it "should return brand set_brand_by_phone if found our number found" do
      @brand.brand_settings.where(:name => "phone_number").first.update_attributes(:setting => 0000000000)
      s = TextMessage.new(0000000001, @brand.name,"text_caster",0000000000)
      s.set_brand_by_phone.should == @brand
    end
    
    it "should return first brand if our number not found" do
      s = TextMessage.new(0000000001, @brand.name,"text_caster",0010000000)
      s.set_brand_by_phone.should == @brand
    end
    
    it "should set_session if chatter has one today" do
      session = Factory(:text_session, :brand => @brand)
      s = TextMessage.new(session.chatter.phone, @brand.name)
      s.set_session.should == session
    end
    
    it "should set_session to a new session if chatter had a session yesterday" do
      session = Factory(:text_session, :brand => @brand)
      session.update_attributes(:created_at => 28.hours.ago)
      lambda {
      s = TextMessage.new(session.chatter.phone, @brand.name)
      }.should change(TextSession, :count).by(1)
    end

    it "should set_session if chatter doesnt have any sessions" do
      chatter = Factory(:chatter)
      lambda {
        s = TextMessage.new(chatter.phone, @brand.name)
      }.should change(TextSession, :count).by(1)
    end
    
  end
  
  context "finds brand, action or tag" do
    before do
      @brand = Factory(:brand)
      @session = Factory(:text_session, :brand => @brand)
      @text_content = Factory(:text_content, :brand => @brand)
    end

    it "should set_action if present" do
      s = TextMessage.new(@session.chatter.phone, @text_content.category.name)
      s.set_action.should == @text_content.category
    end

    it "should set_tag if present" do
      s = TextMessage.new(@session.chatter.phone, @text_content.tag.name)
      s.set_tag.should == @text_content.tag
    end

    
  end
    
  
end