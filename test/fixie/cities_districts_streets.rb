require 'factory_girl'
require 'test/unit/sorted_hierarchy/model'
require 'test/unit/sorted_hierarchy/factories'

city5 = Fixie.create(:city, :with_5_districts)

1.upto(5) do |n|
  Fixie.create(:district, "district#{n}".to_sym, :city => city5.reload)
end

Fixie.create(:city, :to_move_down)
Fixie.create(:city, :to_delete)
city1 = Fixie.create(:city, :to_move_up)
city2 = Fixie.create(:city, :another_with_5_districts)

1.upto(5) do |n|
  Fixie.create(:district, "district2#{n}".to_sym, :city => city2.reload)
end

district5 = Fixie.create(:district, :with_5_streets, :city => city1)

(1..5).each do |n|
  Fixie.create(:street, "street#{n}".to_sym, :district => district5.reload)
end

district6 = Fixie.create(:district, :another_with_5_streets, :city => city1)

(1..5).each do |n|
  Fixie.create(:street, "street2#{n}".to_sym, :district => district6.reload)
end
