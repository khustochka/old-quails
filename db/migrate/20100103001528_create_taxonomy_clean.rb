class CreateTaxonomyClean < ActiveRecord::Migration
  def self.up
    create_table :ordines do |t|
      t.string :name_la, :null => false, :limit => 128
      t.string :name_en, :limit => 128
      t.string :name_ru, :null => false, :limit => 128
      t.string :name_uk, :null => false, :limit => 128
      t.text :description
      t.string :synonims, :limit => 256
      t.integer :sort, :null => false
    end
    
    add_index :ordines, :name_la
    add_index :ordines, :sort
    
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

    add_index :familiae, :name_la
    add_index :familiae, [:ordo_id, :sort]

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
      t.string "iucn_id"
      t.string "iucn_status",     :limit => 2
      t.string "iucn_name_la"
    end

    add_index :species, :name_la
    add_index :species, :code
    add_index :species, :iucn_status
    add_index :species, [:familia_id, :sort]
  end

  def self.down
    drop_table :ordines
    drop_table :familiae
    drop_table :species
  end
end
