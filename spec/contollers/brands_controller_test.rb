require 'test_helper'

class BrandsControllerTest < ActionController::TestCase

  context "User" do
    setup do
      @user = new_poweron_account
      sign_in_as(@user)
    end
    
    should "Be able to swap brands" do
      get 'show', :id => @user.account.brands.first.id
      assert_equal session[:brand], @user.account.brands.first.id
      assert_redirected_to '/dashboard'
    end
    
    should "Not be able to access brand admin functions" do
      get 'index'
    end
  end
  
  context "Brand Admin" do
    setup do
      @user = new_poweron_account   
      sign_in_as(@user)
    end
    
    should "Be a brand admin" do
      get 'show', :id => @user.account.brands.first.id
      assert_equal session[:brand], @user.account.brands.first.id
      get 'index'
      assert_redirected_to '/dashboard'      
    end
  end
  
  context "Super Admin" do
    setup do
      @user = new_poweron_account
      @user.update_attributes(:admin => true)   
      sign_in_as(@user)
    end
    
    should "Be a super admin" do
      get 'show', :id => @user.account.brands.first.id
      assert_equal session[:brand], @user.account.brands.first.id
      get 'index'
      assert_response :success      
    end
    
    should "Be able to add an admin to a brand" do
      
    end
    
  end

end
