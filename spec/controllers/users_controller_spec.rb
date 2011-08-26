require 'spec_helper'

describe UsersController do
  describe "User not signed in" do
    before do
      @user = Factory(:user)
    end

    context "has no access" do
      it "for new" do
        get :new
        response.should redirect_to new_user_session_path
      end
      
      it "for edit" do
        get :edit, :id => @user.id
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
        new_email = Faker::Internet.email
        put :update, :id => @user.id, :user => {:email => new_email}
        response.should redirect_to new_user_session_path
      end
      
      it "for destroy" do
        delete :destroy, :id => @user.id
        response.should redirect_to new_user_session_path
      end
      
    end
  end
  
  describe "User signed in, not admin, " do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @brand = Factory(:brand)
      session[:brand] = @brand.id
      request.env["HTTP_REFERER"] = root_url      
    end

    context "has no access" do
      before do
        request.env['HTTP_REFERER'] = root_url
      end
      it "for new" do
        get :new
        response.should redirect_to :back
      end
            
      it "for create" do
        post :create
        response.should redirect_to :back
      end
      
      it "for destroy" do
        delete :destroy, :id => @user.id
        response.should redirect_to :back
      end
    end
    
    context "Can access" do
      it "index" do
        get :index
        response.should be_success
      end
      
      it "for edit" do
        get :edit, :id => @user.id
        response.should be_success
      end
      
      it "for update" do
        new_email = Faker::Internet.email
        put :update, :id => @user.id, :user => {:email => new_email}
        User.find(@user.id).email.should == new_email
        response.should redirect_to users_path
      end
      
      
    end
  end
  
  describe "User signed in, as admin, " do
    before do
      @user = Factory(:admin_user)
      sign_in(@user)
      @brand = Factory(:brand)
      session[:brand] = @brand.id
      @user2 = Factory(:user)
      request.env["HTTP_REFERER"] = root_url      
    end

    context "has access" do
      
      it "for new" do
        get :new
        response.should be_success
      end
      
      it "for edit themselves" do
        get :edit, :id => @user.id
        assigns[:user].should == @user
        response.should be_success
      end
      
      it "for edit of other" do
        get :edit, :id => @user2.id
        assigns[:user].should == @user2
        response.should be_success
      end
      
      it "for create" do
        lambda {
          post :create, :user => Factory.attributes_for(:user)
        }.should change(User, :count).by(1) 
        response.should redirect_to users_path
      end
      
      it "for update their own info" do
        new_email = Faker::Internet.email
        put :update, :id => @user.id, :user => {:email => new_email}
        User.find(@user.id).email.should == new_email
        response.should redirect_to users_path
      end
      
      it "for update another's info" do
        new_email = Faker::Internet.email
        put :update, :id => @user2.id, :user => {:email => new_email}
        User.find(@user2.id).email.should == new_email
        assigns[:user].should == @user2
        response.should redirect_to users_path
      end
      
      it "for destroy" do
        lambda {
          delete :destroy, :id => @user2.id
        }.should change(User, :count).by(-1)
        response.should redirect_to users_path
      end

      it "index" do
        get :index
        response.should be_success
      end
            
    end
  end
end
