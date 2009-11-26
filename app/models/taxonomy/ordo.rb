class Ordo < Taxon

  validates_format_of :name_la, :with => /^[A-Z][a-z]+formes$/
  validates_uniqueness_of :sort

  has_many :subtaxa, :class_name => "Familia", :foreign_key => "ordo_id", :order => "sort"

end
