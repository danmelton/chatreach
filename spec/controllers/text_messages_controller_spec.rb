require 'spec_helper'

describe TextMessagesController do
  before do
    @brand = Factory(:brand)
    @brand.welcome.update_attributes(:setting => "welcome")
    @chatter = Factory(:chatter)    
    @text_content = Factory(:text_content, :brand => @brand)
  end
  
  context "text caster" do
    it 'should assign the response' do
      @brand.provider.update_attributes(:setting => "Text Caster")      
      get :index, :phoneNumber => "913888833#{rand(9)}", :message => @brand.name
      assigns[:response].should == @brand.welcome.setting
    end
    
    it "should return response" do
      @brand.provider.update_attributes(:setting => "Text Caster")      
      get :index, :phoneNumber => "913888833#{rand(9)}", :message => @brand.name
      @response.body.should == "<root><result><![CDATA["+@brand.welcome.setting+"]]></result></root>"
    end
  end
  
  context "twilio" do
    
    it 'should assign the response' do
      @brand.provider.update_attributes(:setting => "Twilio") 
      @brand.phone_number.update_attributes(:setting => "9999999999")            
      get :index, :SmsSid => rand(9), :Body => @brand.name, :From => @chatter.phone, :To => 9999999
      assigns[:response].should == @brand.welcome.setting
    end
    
    it "should return response" do
      @brand.provider.update_attributes(:setting => "Twilio") 
      @brand.phone_number.update_attributes(:setting => "9999999999")            
      get :index, :SmsSid => rand(9), :Body => @brand.name, :From => @chatter.phone, :To => 9999999
      @response.body.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Sms>"+@brand.welcome.setting+"</Sms></Response>"
    end
  end
  
  context "tropos" do
    
    it 'should assign the response' do
      @brand.provider.update_attributes(:setting => "Tropos") 
      @brand.phone_number.update_attributes(:setting => "9999999999")            
      post :index, :session => {:initialText => @brand.name, :from => @chatter.phone}
      assigns[:response].should == @brand.welcome.setting
    end
    
    it "should return response" do
      @brand.provider.update_attributes(:setting => "Tropos") 
      @brand.phone_number.update_attributes(:setting => "9999999999")            
      post :index, :session => {:initialText => @brand.name, :from => @chatter.phone}
      @response.body.should == "{\"tropo\":[{\"say\":[{\"value\":\""+@brand.welcome.setting+"\"}]}]}"
    end
  end
  

end