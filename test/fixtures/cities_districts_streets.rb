require 'factory_girl'
require 'test/unit/sorted_hierarchy/model'
require 'test/unit/sorted_hierarchy/factories'

city = Array.new(5) do |n|
  Factory.create(:city)
end

city[1].children.create(Factory.attributes_for(:district))

5.times do
  city[2].children.create(Factory.attributes_for(:district))
end