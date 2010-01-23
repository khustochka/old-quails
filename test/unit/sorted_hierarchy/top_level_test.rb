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
  end

end