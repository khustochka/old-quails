class CreateOrdines < ActiveRecord::Migration
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
  end

  def self.down
    drop_table :ordines
  end
end
