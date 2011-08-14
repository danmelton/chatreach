require 'spec_helper'

describe CategoriesController do 
  before do
    @brand = Factory(:brand)      
    session[:brand] = @brand.id      
  end
  describe "User not signed in" do
    before do
      @category = Factory(:category)
    end

    context "has no access" do
      it "for new" do
        get :new
        response.should redirect_to new_user_session_path
      end
      
      it "for edit" do
        get :edit, :id => @category.id
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
        put :update, :id => @category.id, :category => {:name => @category.name + "1"}
        response.should redirect_to new_user_session_path
      end
      
      it "for destroy" do
        delete :destroy, :id => @category.id
        response.should redirect_to new_user_session_path
      end
      
    end
  end  
  
  describe "User signed in, not admin, " do
    before do
      @user = Factory(:user)
      sign_in(@user)
      @category = Factory(:category)
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
        get :edit, :id => @category.id
        response.should redirect_to :back
      end
      
      it "for create" do
        post :create
        response.should redirect_to :back
      end
      
      it "for update" do
        put :update, :id => @category.id
        response.should redirect_to :back
      end
      
      it "for destroy" do
        delete :destroy, :id => @category.id
        response.should redirect_to :back
      end
    end
    
    context "Can access" do
      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @category.id
        response.should be_success
      end
      
    end
  end

  describe "User signed in, as admin, " do
    before do
      @user = Factory(:admin_user)
      sign_in(@user)
      @category = Factory(:category)
    end

    context "has access" do
      
      it "for new" do
        get :new
        response.should be_success
      end
      
      it "for edit" do
        get :edit, :id => @category.id
        response.should be_success
      end
      
      it "for create" do
        lambda {
          post :create, :category => Factory.attributes_for(:category)
        }.should change(Category, :count).by(1) 
        response.should be_success
      end
      
      it "for update" do
        put :update, :id => @category.id, :category => {:name => "love"}
        Category.find(@category.id).name.should == "love"
        response.should redirect_to category_path(@category)
      end
      
      it "for destroy" do
        lambda {
          delete :destroy, :id => @category.id
        }.should change(Category, :count).by(-1)
        response.should redirect_to categories_path
      end

      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @category.id
        response.should be_success
      end
      
    end
    
    context "returns category if already exist" do
      it "for update" do
        put :create, :category => {:name => @category.name}
        response.should redirect_to category_path(@category)
      end
    end
  end  
  
  describe "User signed in, as brand admin, " do
    before do
      @user = Factory(:user)
      @brand.admins << @user
      sign_in(@user)
      @category = Factory(:category)
    end

    context "has access" do
      
      it "for new" do
        get :new
        response.should be_success
      end
      
      it "for edit" do
        get :edit, :id => @category.id
        response.should be_success
      end
      
      it "for create" do
        lambda {
          post :create, :category => Factory.attributes_for(:category)
        }.should change(Category, :count).by(1) 
        response.should be_success
      end
      
      it "for update" do
        put :update, :id => @category.id, :category => {:name => "love"}
        Category.find(@category.id).name.should == "love"
        response.should redirect_to category_path(@category)
      end
      
      it "for destroy" do
        lambda {
          delete :destroy, :id => @category.id
        }.should change(Category, :count).by(-1)
        response.should redirect_to categories_path
      end

      it "index" do
        get :index
        response.should be_success
      end
      
      it "show" do
        get :show, :id => @category.id
        response.should be_success
      end
      
    end
  end  
  
  
end