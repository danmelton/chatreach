require 'spec_helper'

describe TextContentsController do
  before do
    stub_request(:get, "http://maps.googleapis.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => fixture('google_maps'), :headers => {})    
    @brand = Factory(:brand)
    session[:brand] = @brand.id
  end
  
  describe "User not signed in" do
    before do
      @text_content = Factory(:text_content, :brand => @brand)
    end

    context "has no access" do
      it "for new" do
        get :new
        response.should redirect_to new_user_session_path
      end
      
      it "for edit" do
        get :edit, :id => @text_content.id
        response.should redirect_to new_user_session_path
      end
      
      it "for index" do
        get :index
        response.should redirect_to new_user_session_path
      end
      
      it "for create" do
        post :create
        response.should redirect_to new_user_session_path
      end
      
      it "for update" do
        put :update, :id => @text_content.id, :text_content => {:response => @text_content.response + "1"}
        response.should redirect_to new_user_session_path
      end
      
      it "for destroy" do
        delete :destroy, :id => @text_content.id
        response.should redirect_to new_user_session_path
      end
      
    end
  end
  
  describe "User signed in, not admin, " do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @text_content = Factory(:text_content, :brand => @brand)
    end

    context "has no access" do
      before do
        request.env['HTTP_REFERER'] = root_url
      end
      it "for new" do
        get :new
        response.should redirect_to :back
      end
      
      it "for edit" do
        get :edit, :id => @text_content.id
        response.should redirect_to :back
      end
      
      it "for create" do
        post :create
        response.should redirect_to :back
      end
      
      it "for update" do
        put :update, :id => @text_content.id
        response.should redirect_to :back
      end
      
      it "for destroy" do
        delete :destroy, :id => @text_content.id
        response.should redirect_to :back
      end
    end
    
    context "Can access" do
      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @text_content.id
        response.should be_success
      end
      
    end
  end 
  
  describe "User signed in, as admin, " do
    before do
      @user = Factory(:admin_user)
      sign_in(@user)
      @text_content = Factory(:text_content, :brand => @brand)
    end

    context "has access" do

      it "for new" do
        get :new
        response.should be_success
      end

      it "for edit" do
        get :edit, :id => @text_content.id
        response.should be_success
      end

      it "for create" do
        lambda {
          post :create, :text_content => Factory.attributes_for(:text_content)
        }.should change(TextContent, :count).by(1) 
        response.should redirect_to edit_text_content_path(TextContent.last)
      end

      it "for update" do
        put :update, :id => @text_content.id, :text_content => {:response => "love"}
        TextContent.find(@text_content.id).response.should == "love"
        response.should redirect_to edit_text_content_path(@text_content)
      end

      it "for destroy" do
        lambda {
          delete :destroy, :id => @text_content.id
        }.should change(TextContent, :count).by(-1)
        response.should redirect_to text_contents_path
      end

      it "index" do
        get :index
        response.should be_success
      end

      it "show" do
        get :show, :id => @text_content.id
        response.should be_success
      end

    end
  end
  
  describe "User signed in, as brand admin, " do
    before do
      @user = Factory(:user)
      @brand.admins << @user
      sign_in(@user)
      @text_content = Factory(:text_content, :brand => @brand)
    end

    context "has access" do

      it "for new" do
        get :new
        response.should be_success
      end

      it "for edit" do
        get :edit, :id => @text_content.id
        response.should be_success
      end

      it "for create" do
        lambda {
          post :create, :text_content => Factory.attributes_for(:text_content, :brand => @brand)
        }.should change(TextContent, :count).by(1) 
        response.should redirect_to edit_text_content_path(TextContent.last)
      end

      it "for update" do
        put :update, :id => @text_content.id, :text_content => {:response => "love"}
        TextContent.find(@text_content.id).response.should == "love"
        response.should redirect_to edit_text_content_path(@text_content)
      end

      it "for destroy" do
        lambda {
          delete :destroy, :id => @text_content.id
        }.should change(TextContent, :count).by(-1)
        response.should redirect_to text_contents_path
      end

      it "index" do
        get :index
        response.should be_success
      end

      it "show" do
        get :show, :id => @text_content.id
        response.should be_success
      end

    end
  end
   
end
