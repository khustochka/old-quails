require 'test/unit/sorted_hierarchy/test_helper'

class SortedHierarchyLowLevelTest < ActiveSupport::TestCase
  context "Low level object" do

    setup do
      Street.count.should == 5
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
  end

end