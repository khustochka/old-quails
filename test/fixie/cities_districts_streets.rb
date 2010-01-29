require 'factory_girl'
require 'test/unit/sorted_hierarchy/model'
require 'test/unit/sorted_hierarchy/factories'

Fixie.create(:city, :with_5_districts)

1.upto(5) do |n|
  Fixie.create(:district, "district#{n}".to_sym, :city => Fixie.cities(:with_5_districts))
end

Factory.create(:city)
Fixie.create(:city, :to_delete)
city1 = Factory.create(:city)
Factory.create(:city)

Fixie.create(:district, :with_5_streets, :city => city1) 

(1..5).each do |n|
  Fixie.create(:street, "street#{n}".to_sym, :district => Fixie.districts(:with_5_streets))
end
