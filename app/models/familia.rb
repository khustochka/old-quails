class Familia < Taxon
  set_table_name "familiae"
  validates_format_of :name_la, :with => /^[A-Z][a-z]+dae$/
  validates_uniqueness_of :name_la, :name_ru, :name_uk, :sort

  belongs_to :ordo
end
