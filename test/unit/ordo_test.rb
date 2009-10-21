require 'test_helper'

class OrdoTest < ActiveSupport::TestCase

  test "insert should preserve sorting" do
    assert_difference("Ordo.count", 1) do
      Ordo.new(:name_la => "Midiformes", :name_ru => "Среднеобразные", :name_uk => "Середньоподібні", :sort => Ordo.count / 2).insert_mind_sorting
    end
    assert_equal Ordo.find_by_name_la("Midiformes")[:sort], Ordo.count / 2, "Badly inserted"
    assert_equal( (1..Ordo.count).to_a, Ordo.all(:order => :sort).map {|item| item[:sort] }, "Sorting invalid" )
  end

  test "destroy should preserve sorting" do
    assert_difference("Ordo.count", -1) do
      Ordo.find_by_sort(Ordo.count / 2).destroy_mind_sorting
    end
    assert_equal( (1..Ordo.count).to_a, Ordo.all(:order => :sort).map {|item| item[:sort] }, "Sorting invalid" )
  end

  test "move down should preserve sorting" do
    for_update = Ordo.find_by_sort(Ordo.count / 3)
    for_update.update_mind_sorting(:sort => Ordo.count * 2 / 3)

    assert_equal Ordo.count * 2 / 3, Ordo.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_equal( (1..Ordo.count).to_a, Ordo.all(:order => :sort).map {|item| item[:sort] }, "Sorting invalid" )
  end

  test "move up should preserve sorting" do
    for_update = Ordo.find_by_sort(Ordo.count * 2 / 3)
    for_update.update_mind_sorting(:sort => Ordo.count / 3)

    assert_equal Ordo.count / 3, Ordo.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_equal( (1..Ordo.count).to_a, Ordo.all(:order => :sort).map {|item| item[:sort] }, "Sorting invalid" )
  end

end
