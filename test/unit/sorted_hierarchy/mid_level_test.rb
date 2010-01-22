require 'test/unit/sorted_hierarchy/test_helper'

class SortedHierarchyMidLevelTest < ActiveSupport::TestCase
  context "Mid level object" do

    setup do
      District.count.should == 6
      District.should be_sorted
    end

    should "be created successfully with sort = 6" do
      @new_district = Factory.build(:district, :city => City.find_by_sort(3), :sort_num => 6)
      lambda {
        @new_district.save!
      }.should change(District, :count).by(1)
      @new_district.sort_num.should == 6
      District.should be_sorted
    end

    should "be created successfully with sort = nil" do
      @new_district = Factory.build(:district, :city => City.find_by_sort(3))
      lambda {
        @new_district.save!
      }.should change(District, :count).by(1)
      @new_district.sort_num.should == 6
      District.should be_sorted
    end

    should "not be created with invalid sort" do
      lambda {
        Factory.build(:district, :city => City.find_by_sort(3), :sort_num => "first").save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      District.should be_sorted
    end

    should "not be created with sort too large" do
      lambda {
        Factory.build(:district, :city => City.find_by_sort(3), :sort_num => 56).save!
      }.should raise_exception(ActiveRecord::RecordInvalid)
      District.should be_sorted
    end

    should "preserve sorting when destroyed" do
      @old_district = District.find_by_sort_num(5)
      lambda {
        @old_district.destroy
      }.should change(District, :count).by(-1)
      District.should be_sorted
    end
  end

end