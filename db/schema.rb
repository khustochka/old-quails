# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090713183311) do

  create_table "ordines", :force => true do |t|
    t.string  "name_la",     :limit => 128, :default => "", :null => false
    t.string  "name_en",     :limit => 128, :default => "", :null => false
    t.string  "name_ru",     :limit => 128, :default => "", :null => false
    t.string  "name_uk",     :limit => 128, :default => "", :null => false
    t.text    "description",                                :null => false
    t.string  "synonims",    :limit => 256, :default => "", :null => false
    t.integer "sort",                                       :null => false
  end

end
