class PureSQLMigrationS < ActiveRecord::Migration
  def self.up

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
    execute "ALTER TABLE familia DROP FOREIGN KEY familia_fk_ordo_id"
    execute "ALTER TABLE species DROP FOREIGN KEY species_fk_familia_id"
  end
end
