require 'test_helper'

class DomainsControllerTest < ActionController::TestCase
  
  context "Test Different url combos" do
    setup do
      @user = Factory(:user_account)
      @sext = Factory(:brand, :name => 'sext')
      @poweron = Factory(:brand, :name => 'poweron')      
    end
    
    # Replace this with your real tests.
    should "Direct to PowerOn" do
      brand_setting = Factory(:brand_setting, :brand => @poweron, :name => 'domain', :account => @user.account, :setting => 'poweron.localhost')
      @request.host = brand_setting.setting
      get 'index'
      assert_redirected_to :controller => 'poweron', :action => "index"
    end
  
    should "Direct to Chatreach Main" do
      @request.host = 'chatreach.localhost'
      get 'index'
      assert_redirected_to :controller => 'home', :action => "index"
    end
  
    should "Direct to Sext" do
      brand_setting = Factory(:brand_setting, :brand => @sext,  :name => 'domain', :account => @user.account, :setting => 'sext.localhost')      
      @request.host = brand_setting.setting
      get 'index'
      assert_redirected_to :controller => 'sext', :action => "index"
    end
  end
  
end
