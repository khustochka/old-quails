require 'test_helper'

class OrdoTest < ActiveSupport::TestCase

  test "insert should preserve sorting" do
    new_sort = Ordo.count / 2
    assert_difference("Ordo.count", 1) do
      Ordo.new(:name_la => "Midiformes", :name_ru => "Среднеобразные", :name_uk => "Середньоподібні", :description => '', :sort => new_sort).insert_mind_sorting
    end
    assert_equal Ordo.find_by_name_la("Midiformes")[:sort], new_sort, "Badly inserted"
    assert_sorting_preserved(Ordo)
  end

  test "destroy should preserve sorting" do
    assert_difference("Ordo.count", -1) do
      Ordo.find_by_sort(Ordo.count / 2).destroy_mind_sorting
    end
    assert_sorting_preserved(Ordo)
  end

  test "move down should preserve sorting" do
    new_sort = Ordo.count * 2 / 3
    for_update = Ordo.find_by_sort(Ordo.count / 3)
    for_update.update_mind_sorting(:sort => new_sort)

    assert_equal new_sort, Ordo.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Ordo)
  end

  test "move up should preserve sorting" do
    new_sort = Ordo.count / 3
    for_update = Ordo.find_by_sort(Ordo.count * 2 / 3)
    for_update.update_mind_sorting(:sort => new_sort)

    assert_equal new_sort, Ordo.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Ordo)
  end

  test "invalid add should preserve sorting" do
    assert_raise(ActiveRecord::RecordInvalid) do
      assert_difference("Ordo.count", 0) do
        Ordo.new(:name_la => "Scolopaci", :sort => Ordo.count / 2).insert_mind_sorting
      end
    end
    assert_nil Ordo.find_by_name_la("Scolopaci")
    assert_sorting_preserved(Ordo)
  end

  test "invalid edit should preserve sorting" do
    assert_raise(ActiveRecord::RecordInvalid) do
      assert_difference("Ordo.count", 0) do
        for_update = Ordo.find_by_sort(Ordo.count * 2 / 3)
        for_update.update_mind_sorting(:name_la => "Scolopaci", :sort => Ordo.count / 3)
      end
    end
    assert_nil Ordo.find_by_name_la("Scolopaci")
    assert_sorting_preserved(Ordo)
  end

end