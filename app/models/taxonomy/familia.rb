class Familia < Taxon

  validates_format_of :name_la, :with => /^[A-Z][a-z]+dae$/
  validates_uniqueness_of :sort, :scope => :ordo_id

  child_of :ordo

  parent_for :species, :order => "sort"

end
