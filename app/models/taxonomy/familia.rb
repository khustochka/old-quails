class Familia < Taxon

  validates_format_of :name_la, :with => /^[A-Z][a-z]+dae$/
  validates_uniqueness_of :sort, :scope => :ordo_id

  belongs_to :supertaxon, :class_name => "Ordo", :foreign_key => "ordo_id", :counter_cache => true

  has_many :subtaxa, :class_name => "Species", :foreign_key => "familia_id", :order => "sort"

end
