ActiveRecord::Schema.define(:version => 1) do

  create_table :cities do |t|
    t.column :name, :string, :nil => false
    t.column :sort, :integer, :nil => false
  end

  create_table :districts do |t|
    t.column :name, :string, :nil => false
    t.column :city_id, :integer, :nil => false
    t.column :sort_num, :integer, :nil => false
  end

  create_table :streets do |t|
    t.column :name, :string, :nil => false
    t.column :district_id, :integer, :nil => false
    t.column :sort, :integer, :nil => false
  end
end