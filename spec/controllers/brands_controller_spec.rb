require 'spec_helper'

describe BrandsController do
  describe "User not signed in" do
    before do
      @brand = Factory(:brand)
    end

    context "has no access" do
      it "for new" do
        get :new
        response.should redirect_to new_user_session_path
      end
      
      it "for edit" do
        get :edit, :id => @brand.id
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
        put :update, :id => @brand.id, :brand => {:name => @brand.name + "1"}
        response.should redirect_to new_user_session_path
      end
      
      it "for destroy" do
        delete :destroy, :id => @brand.id
        response.should redirect_to new_user_session_path
      end
      
    end
  end
  
  describe "User signed in, not admin, " do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @brand = Factory(:brand)
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
        get :edit, :id => @brand.id
        response.should redirect_to :back
      end
      
      it "for create" do
        post :create
        response.should redirect_to :back
      end
      
      it "for update" do
        put :update, :id => @brand.id
        response.should redirect_to :back
      end
      
      it "for destroy" do
        delete :destroy, :id => @brand.id
        response.should redirect_to :back
      end
    end
    
    context "Can access" do
      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @brand.id
        response.should be_success
      end
      
    end
  end
  
  describe "User signed in, as admin, " do
    before do
      @user = Factory(:admin_user)
      sign_in(@user)
      @brand = Factory(:brand)
    end

    context "has access" do
      
      it "for new" do
        get :new
        response.should be_success
      end
      
      it "for edit" do
        get :edit, :id => @brand.id
        response.should be_success
      end
      
      it "for create" do
        lambda {
          post :create, :brand => Factory.attributes_for(:brand)
        }.should change(Brand, :count).by(1) 
        response.should redirect_to brand_path(Brand.last)
      end
      
      it "for update" do
        put :update, :id => @brand.id, :brand => {:name => "love"}
        Brand.find(@brand.id).name.should == "love"
        response.should redirect_to brand_path(@brand)
      end
      
      it "for destroy" do
        lambda {
          delete :destroy, :id => @brand.id
        }.should change(Brand, :count).by(-1)
        response.should redirect_to brands_path
      end

      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @brand.id
        response.should be_success
      end
      
    end
  end
  
  describe "User signed in, as brand admin, " do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @brand = Factory(:brand, :admins => [@user] )
    end

    context "has access" do

      it "for edit" do
        get :edit, :id => @brand.id
        response.should be_success
      end
            
      it "for update" do
        put :update, :id => @brand.id, :brand => {:name => "love"}
        Brand.find(@brand.id).name.should == "love"
        response.should redirect_to brand_path(@brand)
      end
      
    end
  end

end
