class CreateSomes < ActiveRecord::Migration
  def self.up
    create_table :somes do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :somes
  end
end
