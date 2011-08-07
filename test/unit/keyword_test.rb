require 'test_helper'

class KeywordTest < ActiveSupport::TestCase

  context "various entry tests" do
    setup do
      Factory(:keyword)
    end
    
    should_validate_presence_of :weight, :content, :brand
    should_belong_to :brand
    
    
  end

end
