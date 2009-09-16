class Familia < Taxon
  
  validates_format_of :name_la, :with => /^[A-Z][a-z]+dae$/
  validates_uniqueness_of :name_la, :name_ru, :name_uk, :sort

  belongs_to :supertaxon, :class_name => "Ordo", :foreign_key => "ordo_id"

  has_many :subtaxa, :class_name => "Species", :foreign_key => "familia_id"
end
