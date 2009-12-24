class StringTest < ActiveSupport::TestCase
  test "slav_humanize test" do
    assert_equal "Цапля большая белая".slav_humanize, "Большая белая цапля"
  end
end