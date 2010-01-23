require 'test/unit/sorted_hierarchy/test_helper'

class SortedHierarchyMidLevelTest < ActiveSupport::TestCase
  context "Mid level object" do

    setup do
      District.count.should == 5
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
  end

end