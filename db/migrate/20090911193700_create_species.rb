class CreateSpecies < ActiveRecord::Migration
  def self.up
    create_table :species do |t|
      t.string  "code",     :limit => 6, :null => false
      t.string  "name_la",     :limit => 128, :default => "", :null => false
      t.string  "authority",     :limit => 128, :null => false
      t.string  "name_en",     :limit => 128, :default => "", :null => false
      t.string  "name_ru",     :limit => 128, :default => "", :null => false
      t.string  "name_uk",     :limit => 128, :default => "", :null => false
      t.text    "description"
      t.text    "my_description"
      t.string  "synonims",    :limit => 256
      t.integer "sort",                                       :null => false
      t.integer "familia_id",                                 :null => false
      t.integer "image_id"
      t.string "iucn_id",     :limit => 2
      t.string "iucn_status"
      t.string "iucn_name_la"                              

    end

    add_index "species", ["name_la"], :name => "name_la"
    add_index "species", ["code"], :name => "code"
    add_index "species", ["sort"], :name => "sort"
    add_index "species", ["familia_id"], :name => "familia_id"
  end

  def self.down
    drop_table :species
  end
end
