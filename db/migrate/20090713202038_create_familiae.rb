class CreateFamiliae < ActiveRecord::Migration
  def self.up
    create_table :familiae do |t|
      t.string  "name_la",     :limit => 128, :default => "", :null => false
      t.string  "name_en",     :limit => 128
      t.string  "name_ru",     :limit => 128, :default => "", :null => false
      t.string  "name_uk",     :limit => 128, :default => "", :null => false
      t.text    "description"
      t.string  "synonims",    :limit => 256
      t.integer "sort",                                       :null => false
      t.integer "ordo_id",                                    :null => false
    end

    add_index "familiae", ["name_la"], :name => "familiae_name_la"
    add_index "familiae", ["sort"], :name => "familiae_sort"
    add_index "familiae", ["ordo_id"], :name => "familiae_ordo_id"
  end

  def self.down
    drop_table :familiae
  end
end
