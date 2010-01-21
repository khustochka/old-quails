require 'factory_girl'
require 'test/unit/sorted_hierarchy/model'
require 'test/unit/sorted_hierarchy/factories'

5.times { Factory.build(:city).save! }