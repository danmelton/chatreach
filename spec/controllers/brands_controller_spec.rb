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
      request.env["HTTP_REFERER"] = root_url      
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
        response.should redirect_to edit_brand_path(Brand.last)
      end
      
      it "for create and option to copy brand creates content" do
        2.times {Factory(:text_content, :brand => @brand)}
        lambda {
          post :create, :brand => Factory.attributes_for(:brand), :copy_brand => {:id => @brand.id}
        }.should change(Brand, :count).by(1)
        TextContent.count.should == 4
        response.should redirect_to edit_brand_path(Brand.last)
      end      
      
      it "for update" do
        put :update, :id => @brand.id, :brand => {:name => "love"}
        Brand.find(@brand.id).name.should == "love"
        response.should redirect_to edit_brand_path(@brand)
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
      request.env["HTTP_REFERER"] = root_url
    end

    context "has access" do

      it "for edit" do
        get :edit, :id => @brand.id
        response.should be_success
      end
            
      it "for update" do
        put :update, :id => @brand.id, :brand => {:name => "love"}
        Brand.find(@brand.id).name.should == "love"
        response.should redirect_to edit_brand_path(@brand)
      end
      
    end
    
    describe 'Special. Submitting brand setting attributes' do
      it "for update" do
        # TODO This test could be a littler simpler in prep
        brand_settings = @brand.brand_settings
        brand_settings = brand_settings.map { |x| x.serializable_hash}
        brand_settings = brand_settings.each {|x| x.delete("brand_id"); x.delete("created_at");x.delete("updated_at")}
        brand_settings_attributes = Hash.new
        brand_settings.each_index {|x| brand_settings_attributes["#{x}"] = brand_settings[x] }
        brand_settings_attributes["0"]["setting"] = "Changing!"

        put :update, :id => @brand.id, :brand => {:name => "love", :brand_settings_attributes => brand_settings_attributes}
        Brand.find(@brand.id).name.should == "love"
        Brand.find(@brand.id).welcome.setting.should == "Changing!"        
        response.should redirect_to edit_brand_path(@brand)
      end
    end
  end

end
