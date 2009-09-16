class Ordo < Taxon
  
  validates_format_of :name_la, :with => /^[A-Z][a-z]+formes$/
  validates_uniqueness_of :name_la, :name_ru, :name_uk #, :sort

  has_many :subtaxa, :class_name => "Familia"

end
