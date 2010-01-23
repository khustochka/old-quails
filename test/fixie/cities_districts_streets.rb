require 'factory_girl'
require 'test/unit/sorted_hierarchy/model'
require 'test/unit/sorted_hierarchy/factories'

city1 = Fixie.create(:city, :with_5_districts)

(1..5).each do |n|
  Fixie.create(:district, "district#{n}".to_sym, :city => city1)
end

Factory.create(:city)
Fixie.create(:city, :to_delete)
Factory.create(:city)
Factory.create(:city)