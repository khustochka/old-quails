# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100103001528) do

  create_table "familiae", :force => true do |t|
    t.string  "name_la",     :limit => 128, :default => "", :null => false
    t.string  "name_en",     :limit => 128
    t.string  "name_ru",     :limit => 128, :default => "", :null => false
    t.string  "name_uk",     :limit => 128, :default => "", :null => false
    t.text    "description"
    t.string  "synonims",    :limit => 256
    t.integer "sort",                                       :null => false
    t.integer "ordo_id",                                    :null => false
  end

  add_index "familiae", ["name_la"], :name => "index_familiae_on_name_la"
  add_index "familiae", ["ordo_id", "sort"], :name => "index_familiae_on_ordo_id_and_sort"

  create_table "ordines", :force => true do |t|
    t.string  "name_la",     :limit => 128, :null => false
    t.string  "name_en",     :limit => 128
    t.string  "name_ru",     :limit => 128, :null => false
    t.string  "name_uk",     :limit => 128, :null => false
    t.text    "description"
    t.string  "synonims",    :limit => 256
    t.integer "sort",                       :null => false
  end

  add_index "ordines", ["name_la"], :name => "index_ordines_on_name_la"
  add_index "ordines", ["sort"], :name => "index_ordines_on_sort"

  create_table "species", :force => true do |t|
    t.string  "code",           :limit => 6,                   :null => false
    t.string  "name_la",        :limit => 128, :default => "", :null => false
    t.string  "authority",      :limit => 128,                 :null => false
    t.string  "name_en",        :limit => 128, :default => "", :null => false
    t.string  "name_ru",        :limit => 128, :default => "", :null => false
    t.string  "name_uk",        :limit => 128, :default => "", :null => false
    t.text    "description"
    t.text    "my_description"
    t.string  "synonims",       :limit => 256
    t.integer "sort",                                          :null => false
    t.integer "familia_id",                                    :null => false
    t.integer "image_id"
    t.string  "iucn_id"
    t.string  "iucn_status",    :limit => 2
    t.string  "iucn_name_la"
  end

  add_index "species", ["code"], :name => "index_species_on_code"
  add_index "species", ["familia_id", "sort"], :name => "index_species_on_familia_id_and_sort"
  add_index "species", ["iucn_status"], :name => "index_species_on_iucn_status"
  add_index "species", ["name_la"], :name => "index_species_on_name_la"

end
