class Ordo < Taxon

  validates_format_of :name_la, :with => /^[A-Z][a-z]+formes$/

  parent_for :familiae, :order => "sort"

end
