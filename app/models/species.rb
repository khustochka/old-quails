class Species < Taxon
  
  validates_format_of :code, :with => /^[a-z]{6}$/
  validates_format_of :name_la, :with => /^[A-Z][a-z]+ [a-z]+$/
  validates_uniqueness_of :code, :name_la, :name_ru, :name_uk, :sort

  belongs_to :supertaxon, :class_name => "Familia", :foreign_key => "familia_id"
end