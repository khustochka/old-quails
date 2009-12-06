module Legacy
  class Family < ActiveRecord::Base

    set_table_name "familiae"
    set_primary_key "fam_id"

    belongs_to :order, :class_name => "Legacy::Order", :foreign_key => "ordo_id"
    has_many :species, :class_name => "Legacy::Species", :foreign_key => "fam_id", :order => "sort_num"

  end
end