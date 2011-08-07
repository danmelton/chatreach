require 'test_helper'
require "rexml/document"
require 'hpricot'

class TextMessagesControllerTest < ActionController::TestCase

  context "First time user of text message system" do
     setup do
       @account = Factory(:account)
       @sext = Factory(:sext, :account => @account, :name => "Sext")
       @sext1 = Factory(:sext_description, :account => @sext.account, :brand => @sext.brand)
       @tag = Factory(:tag, :brands => [@sext.brand])
       @tag2 = Factory(:tag, :brands => [@sext.brand])
       @account.brands << @sext.brand
       @phone_new = Factory.next :phone
       @session_new = Factory.next :sessionID
       @carrier = "999999"
     end
   
     should "create a new session for the phone, chatter and profile" do
       assert_difference ['TextSession.count', 'Chatter.count', 'ChatterProfile.count'],1 do
         get 'index', :format=> 'xml', :sessionId =>@session_new, :phoneNumber => @phone_new, :carrierID => "999999", :message => @sext.setting 
       end
       assert_equal(Chatter.last.chatter_profile.phone, @phone_new )
     end
        
     should "charge the account" do
       get 'index', :format=> 'xml', :sessionId =>@session_new, :phoneNumber => @phone_new, :carrierID => "999999", :message => @sext.setting 
     end
   
     should "return the xml" do
       get 'index', :format=> 'xml', :sessionId =>@session_new, :phoneNumber => @phone_new, :carrierID => "999999", :message => @sext.setting 
       doc = Hpricot.parse(@response.body) 
       assert_equal((doc/:result).innerHTML,"\n   <![CDATA["+@sext1.setting+"]]>\n ")
       assert_response :success
       assert_template :index
     end
   
   end

context "Not a first time user of text message system" do
  setup do
    @account = Factory(:account)
    @sext = Factory(:sext, :account => @account, :name => "Sext")
    @sext1 = Factory(:sext_description, :account => @account, :brand => @sext.brand)
    @account.brands << @sext.brand
    @tag = Factory(:tag, :brands => [@sext.brand])
    @tag2 = Factory(:tag, :brands => [@sext.brand])
    @chatter = Factory(:chatter)
    @session = Factory(:text_session, :brand => @sext.brand, :account => @account, :chatter => @chatter)
    @category1 = Factory(:category, :name => "something1")
    @category2 = Factory(:category, :name => "something2")
    @category3 = Factory(:category, :name => "something3")
    @textcontent1 = Factory(:text_content, :brand => @sext.brand, :categories => [@category1], :sext_list => @tag)
    @textcontent2 = Factory(:text_content, :brand => @sext.brand, :categories => [@category2], :sext_list => @tag)
    @textcontent3 = Factory(:text_content, :brand => @sext.brand, :categories => [@category3], :sext_list => @tag)
    @texthistory = Factory(:text_history, :tag => @tag, :text_session => @session)
    @carrier = "999999"
  end
      
      should "load session" do
         assert_no_difference ['TextSession.count', 'Chatter.count', 'ChatterProfile.count'],0 do
           get 'index', :format=> 'xml', :sessionId =>@session.session, :phoneNumber => @chatter.chatter_profile.phone, :carrierID => "999999", :message => @sext.setting 
         end
         assert_equal(1, @chatter.text_sessions.count)
       end
      
      should "return the response xml for the keyword" do
         get 'index', :format=> 'xml', :sessionId =>@session.session, :phoneNumber => @chatter.chatter_profile.phone, :carrierID => "999999", :message => @sext.setting 
         doc = Hpricot.parse(@response.body) 
         assert_equal((doc/:result).innerHTML, "\n   <![CDATA["+@sext1.setting+"]]>\n ")
         assert_response :success
         assert_template :index
       end
     
     should "return the response xml for the tag" do
       get 'index', :format=> 'xml', :sessionId =>@session.session, :phoneNumber => @chatter.chatter_profile.phone, :carrierID => "999999", :message => @tag.name 
       doc = Hpricot.parse(@response.body) 
       assert_equal((doc/:result).innerHTML, "\n   <![CDATA["+"Respond with #{@category1.name}, #{@category2.name}, #{@category3.name} or get help"+"]]>\n ")
       assert_response :success
       assert_template :index
     end
     
     should "return the response xml for an action" do
       get 'index', :format=> 'xml', :sessionId =>@session.session, :phoneNumber => @chatter.chatter_profile.phone, :carrierID => "999999", :message => @category1.name 
       doc = Hpricot.parse(@response.body) 
       assert_equal((doc/:result).innerHTML, "\n   <![CDATA["+@textcontent1.response+"]]>\n ")
       assert_response :success
       assert_template :index
     end
  
end

end
