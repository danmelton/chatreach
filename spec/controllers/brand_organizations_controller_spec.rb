require 'spec_helper'

describe BrandOrganizationsController do
  before do
    stub_request(:get, "http://maps.google.com/maps/api/geocode/json?address=1000%20S%20Van%20Ness,%20San%20Francisco,%20CA,%2094110,%20USA&language=en&sensor=false").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => fixture('google_maps'), :headers => {})
      @organization = Factory(:organization)
      @user = Factory(:user)
      @brand = Factory(:brand, :organizations => [@organization]) 
      session[:brand] = @brand.id     
  end
  
  describe "User not signed in" do

    context "has no access" do
      it "for destroy" do
        delete :destroy, :id => @brand.organizations.first.id, :brand_id => @brand.id
        response.should redirect_to new_user_session_path
      end
      
      it "for create" do
        organization = Factory(:organization)
        post :create, :brand_id => @brand.id, :brand_organization => {:organization => organization}
        response.should redirect_to new_user_session_path
      end
      
    end
    
  end
  
  describe "User signed in as brand admin" do
    before do
      @brand.admins << @user
      sign_in(@user)
    end

    context "can" do
      it "destroy a brand organization" do
        request.env['HTTP_REFERER'] = organizations_path  
        lambda {
          delete :destroy, :brand_id => @brand.id, :id => @brand.brand_organizations.first.id
        }.should change(BrandOrganization, :count).by(-1)
        response.should redirect_to organizations_path
      end
      
      it "create a brand organization" do
        request.env['HTTP_REFERER'] = edit_brand_path(@brand.id)        
        organization = Factory(:organization)
        lambda {
          post :create, :brand_id => @brand.id, :brand_organization => {:organization_id => organization.id, :brand_id => @brand.id}
        }.should change(BrandOrganization, :count).by(1)
        response.should redirect_to edit_brand_path(@brand.id)
      end
      
    end
    
  end
  
  describe "User signed in as admin" do
    before do
      @user = Factory(:admin_user)
      sign_in(@user)
    end

    context "can" do
      it "destroy a brand organization" do
        request.env['HTTP_REFERER'] = brands_path
        lambda {
          delete :destroy, :id => @brand.brand_organizations.first.id, :brand_id => @brand.id
        }.should change(BrandOrganization, :count).by(-1)
        response.should redirect_to brands_path
      end
      
      it "create a brand organization" do
        request.env['HTTP_REFERER'] = edit_brand_path(@brand.id)        
        organization = Factory(:organization)
        lambda {
          post :create, :brand_id => @brand.id, :brand_organization => {:organization => organization, :brand_id => @brand.id}
        }.should change(BrandOrganization, :count).by(1)
        response.should redirect_to edit_brand_path(@brand.id)
      end
      
    end
    
  end
  
end