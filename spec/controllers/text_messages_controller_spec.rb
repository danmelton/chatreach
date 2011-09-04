require 'spec_helper'

describe TextMessagesController do
  before do
    @brand = Factory(:brand)
    @brand.welcome.update_attributes(:setting => "welcome")
    @brand.provider.update_attributes(:setting => "Text Caster")    
    @text_content = Factory(:text_content, :brand => @brand)
  end
  
  context "text caster" do
    it "should return response" do
      get :index, :phoneNumber => "913888833#{rand(9)}", :message => @brand.name
      @response.body.should == "<root><result><![CDATA["+@brand.welcome.setting+"]]></result></root>"
    end
  end
  

end