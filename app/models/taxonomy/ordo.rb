class Ordo < Taxon

  validates_format_of :name_la, :with => /^[A-Z][a-z]+formes$/
  validates_uniqueness_of :sort

  parent_for :familiae, :order => "sort"

end
