require 'test/test_helper'

class StringTest < ActiveSupport::TestCase
  test "slav_humanize test" do
    assert_equal "Большая белая цапля", "Цапля большая белая".slav_humanize
  end
end