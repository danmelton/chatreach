require 'test_helper'

class TagTypoTest < ActiveSupport::TestCase
  should_belong_to :tag

  should "create and destroy depedent tag typos" do
    @count = TagTypo.count
    Factory(:tag)
    assert_equal(true, @count < TagTypo.count )
    Tag.last.destroy
    assert_equal(0, TagTypo.count )
  end

end
