module Legacy
  class Species < ActiveRecord::Base

    set_table_name "species"
    set_primary_key "sp_id"

    belongs_to :family, :class_name => "Legacy::Family", :foreign_key => "fam_id" 

  end
end