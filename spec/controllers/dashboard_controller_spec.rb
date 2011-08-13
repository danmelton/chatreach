require 'spec_helper'

describe DashboardController do
  before do
    @brand = Factory(:brand)
  end
  
  context 'Not signed in' do
    
    it "deny index" do
      get :index
      should redirect_to new_user_session_path
    end
    
  end
  
  context 'signed in' do
    
    it "allow index" do
      @user = Factory(:user)
      sign_in(@user)
      get :index
      session[:brand].should == @brand.id
      response.should be_success
    end
    
  end
end
    
    

