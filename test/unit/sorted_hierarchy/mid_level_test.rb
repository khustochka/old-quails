require 'test/unit/sorted_hierarchy/test_helper'

class SortedHierarchyMidLevelTest < ActiveSupport::TestCase
  context "Mid level object" do

    setup do
      District.count.should == 12
      District.should be_sorted
    end

    should "be created successfully with sort = 3" do
      @new_district = Factory.build(:district, :city => Fixie.cities(:with_5_districts), :sort_num => 3)
      lambda {
        @new_district.save!
      }.should change(District, :count).by(1)
      @new_district.sort_num.should == 3
      District.should be_sorted
    end

    should "be created successfully with sort = nil" do
      @new_district = Factory.build(:district, :city => Fixie.cities(:with_5_districts))
      lambda {
        @new_district.save!
      }.should change(District, :count).by(1)
      @new_district.sort_num.should == 6
      District.should be_sorted
    end

    should "not be created with invalid sort" do
      lambda {
        Factory.build(:district, :city => Fixie.cities(:with_5_districts), :sort_num => "first").save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      District.should be_sorted
    end

    should "not be created with sort too large" do
      lambda {
        Factory.build(:district, :city => Fixie.cities(:with_5_districts), :sort_num => 56).save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      District.should be_sorted
    end

    should "preserve sorting when destroyed" do
      @to_delete = Fixie.districts(:district3)
      lambda {
        @to_delete.destroy
      }.should change(District, :count).by(-1)
      District.should be_sorted
    end

    should "be moved down correctly" do
      @to_move = Fixie.districts(:district2)
      last = @to_move.siblings_scope.last
      @to_move.sort_num = @to_move.siblings_count
      @to_move.save!
      District.should be_sorted
      last.reload.sort_num.should == @to_move.siblings_count - 1
    end

    should "be moved up correctly" do
      @to_move = Fixie.districts(:district4)
      first = @to_move.siblings_scope.first
      @to_move.sort_num = 1
      @to_move.save!
      District.should be_sorted
      first.reload.sort_num.should == 2
    end

    should "preserve sorting if not changed" do
      @to_change = Fixie.districts(:district2)
      sort = @to_change.sort_num
      @to_change.name = "Torgmash"
      @to_change.save!
      District.should be_sorted
      @to_change.sort_num.should == sort
    end

    should "be seamlessly moved to another parent" do
      @to_change = Fixie.districts(:district22)
      @to_change.city_id = Fixie.cities(:with_5_districts).id
      @to_change.sort_num = 1 # this change must not be saved - will be appended to the end
      @to_change.save!
      District.should be_sorted
      @to_change.reload.sort_num.should == @to_change.siblings_count
    end
  end

end