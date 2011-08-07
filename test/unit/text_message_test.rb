require 'test_helper'

class TextMessageTest < ActiveSupport::TestCase
  
  context "Process Text Message" do
    setup do
      @account = Factory(:account)
      @brand = Factory(:brand, :name=>'Sext')
      @account.brands << @brand
      @sext = Factory(:sext, :account => @account, :setting => "sext", :brand => @brand)
      @sext1 = Factory(:sext, :account => @account, :setting => "Welcome to the Sext line!", :name => "description", :brand => @brand)      
      @tag = Factory(:tag, :brands => [@sext.brand])
      @tag2 = Factory(:tag, :brands => [@sext.brand])
      @phone_new = Factory.next :phone
      @chatter = Factory(:chatter)
      @session = Factory(:text_session, :brand => @sext.brand, :account => @account)
      @session_new = Factory.next :sessionID
      @category1 = Factory(:category, :name => "something1")
      @category2 = Factory(:category, :name => "something2")
      @category3 = Factory(:category, :name => "something3")
      @category4 = Factory(:category, :name => "no action")      
      @textcontent1 = Factory(:text_content, :brand => @sext.brand, :categories => [@category1], :sext_list => @tag)
      @textcontent2 = Factory(:text_content, :brand => @sext.brand, :categories => [@category2], :sext_list => @tag)
      @textcontent3 = Factory(:text_content, :brand => @sext.brand, :categories => [@category3], :sext_list => @tag)
      @textcontent4 = Factory(:text_content, :response => "this is the content", :brand => @sext.brand, :categories => [@category4], :sext_list => @tag2)      
      @texthistory = Factory(:text_history, :tag => @tag, :text_session => @session)
      @oprofile1 = Factory(:oprofile, :sext_list => @tag, :sms_about => "something1")
      @oprofile2 = Factory(:oprofile, :address=>"19905 S Clinton", :city => "Olathe", :zip => "66215", :sext_list => @tag, :sms_about => "something2")
      Factory(:account_organization, :oprofile => @oprofile1, :account => @account, :brand => @sext.brand)
      Factory(:account_organization, :oprofile => @oprofile2, :account => @account, :brand => @sext.brand)      
      @carrier = Factory(:carrier)
    end
    
    should "Find Keyword" do
            msg = TextMessage.new(@session_new, @phone_new, @carrier.carrierid, @sext.setting)
            assert_equal(@sext, msg.keyword)
            assert_equal(@sext1.setting, msg.response)
          end
          
        should "Find Account" do
          msg = TextMessage.new(@session_new, @phone_new, @carrier.carrierid, @sext.setting)
          assert_equal(@account, msg.account)
        end
           
      should "Find Chatter if exists" do
        msg = TextMessage.new(@session, @chatter.chatter_profile.phone, @carrier.carrierid, @sext.setting)
        assert_equal(@chatter, msg.chatter)
      end
      
      should "Create Chatter if no chatter exists" do
        assert_difference ['Chatter.count', 'ChatterProfile.count'], 1 do
          msg = TextMessage.new(@session_new, @phone_new, @carrier.carrierid, @sext.setting)
        end
        assert_equal(@phone_new, Chatter.last.chatter_profile.phone)
        assert_equal(TextSession.last.phone, @phone_new)
      end
   
   should "Find session if exists" do
     msg = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, @sext.setting)
     assert_equal(@session, msg.session)
     assert_equal(@chatter, msg.chatter)
   end
    
   should "create session, linked to a chatter, if no session but chatter phone exists" do
     msg = TextMessage.new(@session_new, @chatter.chatter_profile.phone, @carrier.carrierid, @sext.setting)
     assert_equal(@session_new, msg.session.session)
     assert_equal(@chatter, msg.session.chatter)
     assert_equal(@chatter, msg.chatter)
   end
     
     should "create session and chatter" do
       assert_difference ['Chatter.count', 'ChatterProfile.count', 'TextSession.count'], 1 do
         msg = TextMessage.new(@session_new, @phone_new, @carrier.carrierid, @sext.setting)
         msg.chatter
         msg.session
       end
     end
       
     should "Find Tag" do
       msg = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, @tag.name)
       assert_equal(@tag, msg.tag)
     end
     
     should "Find tag from session if no tag exists" do
       msg = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, 'nothing')
       assert_equal(nil, msg.tag)
     end
     
     should "Find tag response" do
       msg = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, @tag.name)
       assert_equal("Respond with #{@category1.name}, #{@category2.name}, #{@category3.name} or get help", msg.response)
     end
     
     should "Find category response" do
       msg = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, @tag2.name)
       assert_equal(@textcontent4.response, msg.response)
     end
     
     should "Find no action response if Tag has no action" do
       
     end
    
    should "Detect get help, ask for zipcode and return results" do
      msg1 = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, 'get help')
      assert_equal("Respond with your zipcode for a list of local places to get help. You can also text next for another clinic.", msg1.response)  
      msg2 = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, '66101')
      assert_equal("66101", @chatter.chatter_profile.zipcode)
      assert_equal(@oprofile1.sms_about,msg2.response)        
      msg3 = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, 'next')        
      assert_equal(@oprofile2.sms_about, msg3.response)
      msg4 = TextMessage.new(@session.session, @chatter.chatter_profile.phone, @carrier.carrierid, 'next')        
      assert_equal(@oprofile1.sms_about, msg4.response)                
    end
  
  end
  
end
