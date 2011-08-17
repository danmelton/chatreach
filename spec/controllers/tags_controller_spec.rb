require 'spec_helper'

describe TagsController do 
  before do
    @brand = Factory(:brand)      
    session[:brand] = @brand.id      
  end
  describe "User not signed in" do
    before do
      @tag = Factory(:tag)
    end

    context "has no access" do
      it "for new" do
        get :new
        response.should redirect_to new_user_session_path
      end
      
      it "for edit" do
        get :edit, :id => @tag.id
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
        put :update, :id => @tag.id, :tag => {:name => @tag.name + "1"}
        response.should redirect_to new_user_session_path
      end
      
      it "for destroy" do
        delete :destroy, :id => @tag.id
        response.should redirect_to new_user_session_path
      end
      
    end
  end  
  
  describe "User signed in, not admin, " do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @tag = Factory(:tag)
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
        get :edit, :id => @tag.id
        response.should redirect_to :back
      end
      
      it "for create" do
        post :create
        response.should redirect_to :back
      end
      
      it "for update" do
        put :update, :id => @tag.id
        response.should redirect_to :back
      end
      
      it "for destroy" do
        delete :destroy, :id => @tag.id
        response.should redirect_to :back
      end
    end
    
    context "Can access" do
      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @tag.id
        response.should be_success
      end
      
    end
  end

  describe "User signed in, as admin, " do
    before do
      @user = Factory(:admin_user)
      sign_in(@user)
      @tag = Factory(:tag)
    end

    context "has access" do
      
      it "for new" do
        get :new
        response.should be_success
      end
      
      it "for edit" do
        get :edit, :id => @tag.id
        response.should be_success
      end
      
      it "for create" do
        lambda {
          post :create, :tag => Factory.attributes_for(:tag)
        }.should change(Tag, :count).by(1) 
        response.should be_success
      end
      
      it "for update" do
        put :update, :id => @tag.id, :tag => {:name => "love"}
        Tag.find(@tag.id).name.should == "love"
        response.should redirect_to tag_path(@tag)
      end
      
      it "for destroy" do
        lambda {
          delete :destroy, :id => @tag.id
        }.should change(Tag, :count).by(-1)
        response.should redirect_to tags_path
      end

      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @tag.id
        response.should be_success
      end
      
    end
    
    context "returns tag if already exist" do
      it "for update" do
        put :create, :tag => {:name => @tag.name}
        response.should redirect_to tag_path(@tag)
      end
    end
  end  
  
  describe "User signed in, as brand admin, " do
    before do
      @user = Factory(:user)
      @brand.admins << @user
      sign_in(@user)
      @tag = Factory(:tag)
    end

    context "has access" do
      
      it "for new" do
        get :new
        response.should be_success
      end
      
      it "for edit" do
        get :edit, :id => @tag.id
        response.should be_success
      end
      
      it "for create" do
        lambda {
          post :create, :tag => Factory.attributes_for(:tag)
        }.should change(Tag, :count).by(1) 
        response.should be_success
      end
      
      it "for update" do
        put :update, :id => @tag.id, :tag => {:name => "love"}
        Tag.find(@tag.id).name.should == "love"
        response.should redirect_to tag_path(@tag)
      end
      
      it "for destroy" do
        lambda {
          delete :destroy, :id => @tag.id
        }.should change(Tag, :count).by(-1)
        response.should redirect_to tags_path
      end

      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @tag.id
        response.should be_success
      end
      
    end
  end  
  
  
end