class ImproveIndices < ActiveRecord::Migration
  def self.up
    remove_index "familiae", "sort"
    remove_index "familiae", "ordo_id"
    add_index(:familiae, [:ordo_id, :sort])

    remove_index "species", "sort"
    remove_index "species", "familia_id"
    add_index(:species, [:familia_id, :sort])
  end

  def self.down
    remove_index(:familiae, [:ordo_id, :sort])
    add_index "familiae", "sort"
    add_index "familiae", "ordo_id"

    remove_index(:species, [:familia_id, :sort])
    add_index "species", "sort"
    add_index "species", "familia_id"
  end
end
