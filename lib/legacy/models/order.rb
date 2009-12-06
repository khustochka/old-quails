require "active_record"

module Legacy
  class Order < ActiveRecord::Base

    set_table_name "ordines"
    set_primary_key "ordo_id"

    has_many :families, :class_name => "Legacy::Family", :foreign_key => "ordo_id", :order => "fam_id"
  
  end
end