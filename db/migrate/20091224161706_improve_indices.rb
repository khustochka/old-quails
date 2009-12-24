class ImproveIndices < ActiveRecord::Migration
  def self.up
    remove_index "familiae", "sort"
    remove_index "familiae", "ordo_id"
    add_index(:familiae, [:ordo_id, :sort], :unique => true)

    remove_index "species", "sort"
    remove_index "species", "familia_id"
    add_index(:species, [:familia_id, :sort], :unique => true)

    #add foreign keys
    execute <<-SQL
      ALTER TABLE familiae
        ADD CONSTRAINT familia_fk_ordo_id
        FOREIGN KEY (ordo_id)
        REFERENCES ordines(id)
    SQL

    execute <<-SQL
      ALTER TABLE species
        ADD CONSTRAINT species_fk_familia_id
        FOREIGN KEY (familia_id)
        REFERENCES familiae(id)
    SQL
  end

  def self.down
    remove_index(:familiae, [:ordo_id, :sort])
    add_index "familiae", "sort"
    add_index "familiae", "ordo_id"
    execute "ALTER TABLE familia DROP FOREIGN KEY familia_fk_ordo_id"

    remove_index(:species, [:familia_id, :sort])
    add_index "species", "sort"
    add_index "species", "familia_id"
    execute "ALTER TABLE species DROP FOREIGN KEY species_fk_familia_id"
  end
end
