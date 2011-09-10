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
      @response.body.should == "<response><sms>"+@brand.welcome.setting+"</sms></response>"
    end
  end
  

end