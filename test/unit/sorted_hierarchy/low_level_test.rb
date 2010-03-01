require 'test/unit/sorted_hierarchy/test_helper'

class SortedHierarchyLowLevelTest < ActiveSupport::TestCase
  context "Low level object" do

    setup do
      Street.count.should == 10
      Street.should be_sorted
    end

    should "be created successfully with sort = 3" do
      @new_street = Factory.build(:street, :district => Fixie.districts(:with_5_streets), :sort => 3)
      lambda {
        @new_street.save!
      }.should change(Street, :count).by(1)
      @new_street.sort.should == 3
      Street.should be_sorted
    end

    should "be created successfully with sort = nil" do
      @new_street = Factory.build(:street, :district => Fixie.districts(:with_5_streets))
      lambda {
        @new_street.save!
      }.should change(Street, :count).by(1)
      @new_street.sort.should == 6
      Street.should be_sorted
    end

    should "not be created with invalid sort" do
      lambda {
        Factory.build(:street, :district => Fixie.districts(:with_5_streets), :sort => "first").save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      Street.should be_sorted
    end

    should "not be created with sort too large" do
      lambda {
        Factory.build(:street, :district => Fixie.districts(:with_5_streets), :sort => 56).save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      Street.should be_sorted
    end

    should "preserve sorting when destroyed" do
      @to_delete = Fixie.streets(:street3)
      lambda {
        @to_delete.destroy
      }.should change(Street, :count).by(-1)
      Street.should be_sorted
    end

    should "be moved down correctly" do
      @to_move = Fixie.streets(:street2)
      last = @to_move.siblings_scope.last
      @to_move.sort = @to_move.siblings_count
      @to_move.save!
      Street.should be_sorted
      last.reload.sort.should == @to_move.siblings_count - 1
    end

    should "be moved up correctly" do
      @to_move = Fixie.streets(:street4)
      first = @to_move.siblings_scope.first
      @to_move.sort = 1
      @to_move.save!
      Street.should be_sorted
      first.reload.sort.should == 2
    end

    should "preserve sorting if not changed" do
      @to_change = Fixie.streets(:street2)
      sort = @to_change.sort
      @to_change.name = "Korolenko"
      @to_change.save!
      Street.should be_sorted
      @to_change.sort.should == sort
    end

    should "be seamlessly moved to another parent" do
      @to_change = Fixie.streets(:street22)
      @to_change.parent = Fixie.districts(:with_5_streets)
      @to_change.sort = 1 # this change must not be saved - will be appended to the end
      @to_change.save!
      Street.should be_sorted
      @to_change.reload.sort.should == @to_change.siblings_count
      @to_change.district_id.should == Fixie.districts(:with_5_streets).id
    end
  end

end