require 'test/unit/sorted_hierarchy/test_helper'

class SortedHierarchyTopLevelTest < ActiveSupport::TestCase
  context "Top level object" do

    setup do
      City.count.should == 5
      City.should be_sorted
    end

    should "be created successfully with sort = 3" do
      @new_city = Factory.build(:city, :sort => 3)
      lambda {
        @new_city.save!
      }.should change(City, :count).by(1)
      @new_city.sort.should == 3
      City.should be_sorted
    end

    should "be created successfully with sort = nil" do
      @new_city = Factory.build(:city)
      lambda {
        @new_city.save!
      }.should change(City, :count).by(1)
      @new_city.sort.should == City.count
      City.should be_sorted
    end

    should "not be created with invalid sort" do
      lambda {
        Factory.build(:city, :sort => "first").save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      City.should be_sorted
    end

    should "not be created with sort too large" do
      lambda {
        Factory.build(:city, :sort => 56).save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      City.should be_sorted
    end

    should "preserve sorting when destroyed" do
      @to_delete = Fixie.cities(:to_delete)
      lambda {
        @to_delete.destroy
      }.should change(City, :count).by(-1)
      City.should be_sorted
    end

    should "be moved down correctly" do
      @to_move = Fixie.cities(:to_move_down)
      last = City.last
      @to_move.sort = City.count
      @to_move.save!
      City.should be_sorted
      last.reload.sort.should == City.count - 1
    end

    should "be moved up correctly" do
      @to_move = Fixie.cities(:to_move_up)
      first = City.first
      @to_move.sort = 1
      @to_move.save!
      City.should be_sorted
      first.reload.sort.should == 2
    end

    should "preserve sorting if not changed" do
      @to_change = Fixie.cities(:to_move_up)
      sort = @to_change.sort
      @to_change.name = "Boyarka"
      @to_change.save!
      City.should be_sorted
      @to_change.sort.should == sort
    end
  end

end