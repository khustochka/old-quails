require 'test_helper'

class FamiliaTest < ActiveSupport::TestCase

  test "insert should preserve sorting" do
    parent = ordines(:ordines_011)
    new_sort = parent.subtaxa.count / 2
    assert_difference("parent.subtaxa.count", 1) do
      Familia.new(:name_la => "Mididae", :name_ru => "Средневые", :name_uk => "Середневі", :description => '', :ordo_id => ordines(:ordines_011).id, :sort => new_sort).insert_mind_sorting
    end
    assert_equal new_sort, Familia.find_by_name_la("Mididae")[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)
  end

  test "destroy should preserve sorting" do
    parent = ordines(:ordines_011)
    assert_difference("parent.subtaxa.count", -1) do
      familiae(:familiae_013).destroy_mind_sorting
    end
    assert_sorting_preserved(Familia)
  end

  test "move down should preserve sorting" do
    parent = ordines(:ordines_011)
    new_sort = parent.subtaxa.count * 2 / 3
    for_update = familiae(:familiae_013)
    for_update.update_mind_sorting(:sort => new_sort)

    assert_equal new_sort, Familia.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)
  end

  test "move up should preserve sorting" do
    parent = ordines(:ordines_011)
    new_sort = parent.subtaxa.count / 3
    for_update = familiae(:familiae_013)
    for_update.update_mind_sorting(:sort => new_sort)

    assert_equal new_sort, Familia.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)
  end

  test "invalid add should preserve sorting" do
    parent = ordines(:ordines_011)
    assert_raise(ActiveRecord::RecordInvalid) do
      assert_difference("parent.subtaxa.count", 0) do
        Familia.new(:name_la => "Scolopaci", :ordo_id => ordines(:ordines_011).id, :sort => parent.subtaxa.count / 2).insert_mind_sorting
      end
    end
    assert_nil Familia.find_by_name_la("Scolopaci")
    assert_sorting_preserved(Familia)
  end

  test "invalid edit should preserve sorting" do
    parent = ordines(:ordines_011)
    assert_raise(ActiveRecord::RecordInvalid) do
      assert_difference("parent.subtaxa.count", 0) do
        for_update = familiae(:familiae_013)
        for_update.update_mind_sorting(:name_la => "Scolopaci", :sort => parent.subtaxa.count / 3)
      end
    end
    assert_nil Familia.find_by_name_la("Scolopaci")
    assert_sorting_preserved(Familia)
  end

  test "insert with illegal or 0 sort value should append to the end" do
    parent = ordines(:ordines_011)
    assert_difference("parent.subtaxa.count", 1) do
      Familia.new(:name_la => "Zerodae", :name_ru => "Нулебразные", :name_uk => "Нульові", :description => '', :ordo_id => ordines(:ordines_011).id, :sort => 0).insert_mind_sorting
    end
    assert_equal parent.subtaxa.count, Familia.find_by_name_la("Zerodae")[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)

    assert_difference("parent.subtaxa.count", 1) do
      Familia.new(:name_la => "Superidae", :name_ru => "Сверхвые", :name_uk => "Наднові", :description => '', :ordo_id => ordines(:ordines_011).id, :sort => 1000).insert_mind_sorting
    end
    assert_equal parent.subtaxa.count, Familia.find_by_name_la("Superidae")[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)

    assert_difference("parent.subtaxa.count", 1) do
      Familia.new(:name_la => "Xxxdae", :name_ru => "Хххвые", :name_uk => "Хххві", :description => '', :ordo_id => ordines(:ordines_011).id, :sort => "xxx").insert_mind_sorting
    end
    assert_equal parent.subtaxa.count, Familia.find_by_name_la("Xxxdae")[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)
  end

  test "update with illegal or 0 sort value should move to the end" do
    parent = ordines(:ordines_011)
    for_update = familiae(:familiae_013)
    for_update.update_mind_sorting(:sort => 0)
    assert_equal parent.subtaxa.count, Familia.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)

    for_update = familiae(:familiae_013)
    for_update.update_mind_sorting(:sort => 1000)
    assert_equal parent.subtaxa.count, Familia.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)

    for_update = familiae(:familiae_013)
    for_update.update_mind_sorting(:sort => "xxxx")
    assert_equal parent.subtaxa.count, Familia.find_by_name_la(for_update[:name_la])[:sort], "Badly inserted"
    assert_sorting_preserved(Familia)
  end
end
