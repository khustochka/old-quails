class Familia < Taxon

  validates_format_of :name_la, :with => /^[A-Z][a-z]+dae$/

  child_of :ordo

  parent_for :species, :order => "sort"

end
