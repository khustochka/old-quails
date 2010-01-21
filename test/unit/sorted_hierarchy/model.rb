class AdministrativeUnit < ActiveRecord::Base
  include SortedHierarchy::ActiveRecord
  self.abstract_class = true
end

class City < AdministrativeUnit
  parent_for :districts
end

class District < AdministrativeUnit
  parent_for :streets
  child_of :city
  set_sort_column :sort_num
end

class Street < ActiveRecord::Base
  include SortedHierarchy::ActiveRecord
  child_of :city
end