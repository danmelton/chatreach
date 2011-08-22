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
  
  context "response" do
    before do
      @brand = Factory(:brand)
      @text_content = Factory(:text_content, :brand => @brand)
      @session = Factory(:text_session, :brand => @brand)      
      @history = Factory(:text_history, :text_session => @session, :tag => @text_content.tag)
      @brand.brand_settings.where(:name => "welcome").first.update_attributes(:setting => "hi")      
      @brand.brand_settings.where(:name => "info_not_found").first.update_attributes(:setting => "love")      
    end
    
    it 'should return keyword' do
      @brand.welcome.update_attributes(:setting => "text this in")
      s = TextMessage.new(@session.chatter.phone, @brand.name)
      lambda {
        s.is_keyword
      }.should change(TextHistory, :count).by(1)
      s.response.should == "text this in"
    end
    
    it 'should return list' do
      s = TextMessage.new(@session.chatter.phone, "list")
      s.is_list
      s.response.should == s.tag_list.join(", ")
    end
    
    it 'should return list of actions' do
      s = TextMessage.new(@session.chatter.phone, @text_content.tag.name)
      s.tag_actions
      s.actions.should == "#{@text_content.category.name} or get help"
    end
    
    it 'should return list of actions in response to tag' do
      s = TextMessage.new(@session.chatter.phone, @text_content.tag.name)
      lambda {
        s.is_tag
      }.should change(TextHistory, :count).by(1)        
      s.response.should == "Respond with #{@text_content.category.name} or get help"
    end
    
    it 'should return response if tag has a no action category' do
      new_content = Factory(:text_content, :category => Factory(:category, :name => 'no action'), :brand => @brand, :tag =>@text_content.tag)
      s = TextMessage.new(@session.chatter.phone, @text_content.tag.name)
      lambda {
        s.is_tag
      }.should change(TextHistory, :count).by(1)        
      s.response.should == new_content.response
    end
    
    it 'should return list of actions in response if its a tag typoe' do
      s = TextMessage.new(@session.chatter.phone, Tag.first.tag_typos.first.typo)
      lambda {
        s.is_typo
      }.should change(TextHistory, :count).by(1)        
      s.response.should == "Respond with #{@text_content.category.name} or get help"
    end
    
    it 'should return text of action when a text history is found' do
      s = TextMessage.new(@session.chatter.phone, @text_content.category.name)
      s.action_text
      s.response.should == @text_content.response
      lambda {
        s.is_action
      }.should change(TextHistory, :count).by(1)
    end

    it 'should return text of action when a text history session is not found' do
      s = TextMessage.new(rand(10000), @text_content.category.name)
      s.action_text
      s.response.should == @brand.welcome.setting
      lambda {
        s.is_action
      }.should change(TextHistory, :count).by(1)
    end
    
    it 'should return info not found text for brand when nothing is found' do
      s = TextMessage.new(@session.chatter.phone, "bla")
      lambda {
        s.not_found
      }.should change(TextHistory, :count).by(1)
      s.response.should == @brand.info_not_found.setting      
    end
    
    context 'organizations' do
      before do
        stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=94110&language=en&sensor=false").
          with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => fixture('google_maps_zip_94110'), :headers => {})
        stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
          with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => fixture('google_maps'), :headers => {})
        stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=66101&language=en&sensor=false").
          with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
          to_return(:status => 200, :body => fixture('google_maps_zip_66101'), :headers => {})
        @brand.distance_for_organization.update_attributes(:setting => 10)          
        @org = Factory(:organization, :tag_list => [@text_content.tag.name])
        @brand.organizations << @org        
      end

      it 'finds closest organization with tag' do
        s = TextMessage.new(@session.chatter.phone, "94110")      
        s.get_org_list.first.should == @org
      end
      
      it 'doesnt find closest organization with tag' do
        s = TextMessage.new(@session.chatter.phone, "66101")      
        s.get_org_list.should == []
      end
      
      context "is_help" do
        before do
          @brand.organization_not_found.update_attributes(:setting => "not found")
        end
        
        it 'returns org, updates chatter, and adds history' do
          @session.text_histories.last.update_attributes(:text_type => "help")
          s = TextMessage.new(@session.chatter.phone, "94110")      
          lambda {
            s.is_help
          }.should change(TextHistory, :count).by(1)
          @session.reload.chatter.zipcode.should == "94110"
          s.response.should == @org.sms_about
        end
        
        it 'returns organization not found and adds history' do
          @session.text_histories.last.update_attributes(:text_type => "help")
          s = TextMessage.new(@session.chatter.phone, "66101")      
          lambda {
            s.is_help
          }.should change(TextHistory, :count).by(1)
          s.response.should == @brand.organization_not_found.setting
        end
        
        context 'is next' do
          
          it 'gets next organization in an array of two' do
          @org2 = Factory(:organization, :tag_list => [@text_content.tag.name])
          @brand.organizations << @org2
          s = TextMessage.new(@session.chatter.phone, "94110")      
          s.get_next_org(s.get_org_list, @org.sms_about).should == @org2
          end
          
          it 'gets one organization in an array of one' do
          s = TextMessage.new(@session.chatter.phone, "94110")      
          s.get_next_org(s.get_org_list, @org.sms_about).should == @org
          end
          
          it 'response is next organizations sms_about' do
          @org2 = Factory(:organization, :tag_list => [@text_content.tag.name])
          @session.chatter.update_attributes(:zipcode => "94110")
          Factory(:text_history, :text_session=> @session, :response=>@org.sms_about, :tag => @text_content.tag)
          @brand.organizations << @org2
          s = TextMessage.new(@session.chatter.phone, "next")      
          lambda {
            s.is_next
          }.should change(TextHistory, :count).by(1)
          s.response.should == @org2.sms_about
          end
          
          it 'response is organization if only one is in the array' do
          @session.chatter.update_attributes(:zipcode => "94110")
          Factory(:text_history, :text_session=> @session, :response=>@org.sms_about, :tag => @text_content.tag)
          s = TextMessage.new(@session.chatter.phone, "next")      
          lambda {
            s.is_next
          }.should change(TextHistory, :count).by(1)
          s.response.should == @org.sms_about
          end
          
          it 'response is organzation not found' do
          @session.chatter.update_attributes(:zipcode => "66101")
          Factory(:text_history, :text_session=> @session, :response=>@org.sms_about, :tag => @text_content.tag)
          s = TextMessage.new(@session.chatter.phone, "next")      
          lambda {
            s.is_next
          }.should change(TextHistory, :count).by(1)
          s.response.should == @brand.organization_not_found.setting
          end
          
        end
        
      end

    end
    
  end
    
end