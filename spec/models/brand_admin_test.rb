require 'test_helper'

class BrandAdminTest < ActiveSupport::TestCase

  context "Various Tests" do

    setup do
      @user = Factory(:user)
    end

    should_belong_to :user, :brand
    
  end

end
