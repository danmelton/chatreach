require 'spec_helper'

describe BrandAdminsController do
  
  describe "User not signed in" do
    before do
      @brand = Factory(:brand)
    end

    context "has no access" do
      it "for destroy" do
        delete :destroy, :id => @brand.admins.first.id, :brand_id => @brand.id
        response.should redirect_to new_user_session_path
      end
      
      it "for create" do
        user = Factory(:user)
        post :create, :brand_id => @brand.id, :brand_admin => {:admin => user}
        response.should redirect_to new_user_session_path
      end
      
    end
    
  end
  
  describe "User signed in as brand admin" do
    before do
      @user = Factory(:user)
      @brand = Factory(:brand, :admins => [@user])
      sign_in(@user)
    end

    context "can" do
      it "destroy a brand admin" do
        request.env['HTTP_REFERER'] = brands_path
        lambda {
          delete :destroy, :id => @brand.brand_admins.first.id, :brand_id => @brand.id
        }.should change(BrandAdmin, :count).by(-1)
        response.should redirect_to brands_path
      end
      
      it "create a brand admin" do
        request.env['HTTP_REFERER'] = edit_brand_path(@brand.id)        
        user = Factory(:user)
        lambda {
          post :create, :brand_id => @brand.id, :brand_admin => {:user => user, :brand_id => @brand.id}
        }.should change(BrandAdmin, :count).by(1)
        response.should redirect_to edit_brand_path(@brand.id)
      end
      
    end
    
  end
  
  describe "User signed in as admin" do
    before do
      @user = Factory(:admin_user)
      @brand = Factory(:brand, :admins => [@user])
      sign_in(@user)
    end

    context "can" do
      it "destroy a brand admin" do
        request.env['HTTP_REFERER'] = brands_path
        lambda {
          delete :destroy, :id => @brand.brand_admins.first.id, :brand_id => @brand.id
        }.should change(BrandAdmin, :count).by(-1)
        response.should redirect_to brands_path
      end
      
      it "create a brand admin" do
        request.env['HTTP_REFERER'] = edit_brand_path(@brand.id)        
        user = Factory(:user)
        lambda {
          post :create, :brand_id => @brand.id, :brand_admin => {:user => user, :brand_id => @brand.id}
        }.should change(BrandAdmin, :count).by(1)
        response.should redirect_to edit_brand_path(@brand.id)
      end
      
    end
    
  end
  
end