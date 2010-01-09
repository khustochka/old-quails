require 'test/test_helper'

class ObjectTest < ActiveSupport::TestCase
  test "if_present should work" do
    # success tests
    assert_equal "Цаплевые", "Цаплевые".if_present
    assert_equal "<b>Цаплевые</b>", "Цаплевые".if_present { |val| "<b>#{val}</b>" }
    temp = true.if_present("true") rescue "empty"
    assert_equal "true", temp

    # failure tests
    temp = "".if_present! { |val| "<b>#{val}</b>" } rescue "empty"
    assert_equal "empty", temp
    temp = nil.if_present! { |val| "<b>#{val}</b>" } rescue "empty2"
    assert_equal "empty2", temp
    temp = false.if_present! { |val| "<b>#{val}</b>" } rescue "empty3"
    assert_equal "empty3", temp

    temp = "".if_present { |val| "<b>#{val}</b>" }
    assert_equal "", temp
    temp = nil.if_present { |val| "<b>#{val}</b>" }
    assert_equal nil, temp
    temp = false.if_present { |val| "<b>#{val}</b>" }
    assert_equal false, temp
  end
end