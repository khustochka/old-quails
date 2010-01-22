Factory.define :city do |city|
  city.name 'Brovary'
  city.sort nil
end

Factory.define :district do |district|
  district.name 'Massive'
  district.sort_num nil
  district.city nil
end

