require 'test/test_helper'

class TestHelperTest < ActionView::TestCase
  test "assert_sorting_preserved helper is valid" do
    assert_sorting_preserved(Ordo)
    assert_sorting_preserved(Familia)
    assert_sorting_preserved(Species)
  end
end
