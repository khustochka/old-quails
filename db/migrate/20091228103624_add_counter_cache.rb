class AddCounterCache < ActiveRecord::Migration

  def self.up
    add_column :ordines, :familiae_count, :integer, :null => false, :default => 0
    add_column :familiae, :species_count, :integer, :null => false, :default => 0

    execute "UPDATE ordines SET familiae_count = (SELECT COUNT(id) FROM familiae WHERE ordo_id = ordines.id)"
    execute "UPDATE familiae SET species_count = (SELECT COUNT(id) FROM species WHERE familia_id = familiae.id)"
  end

  def self.down
    remove_column :ordines, :familiae_count
    remove_column :familiae, :species_count
  end
end
