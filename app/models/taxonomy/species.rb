class Species < Taxon

  validates_format_of :code, :with => /^[a-z]{6}$/
  validates_format_of :name_la, :with => /^[A-Z][a-z]+ [a-z]+$/
  validates_uniqueness_of :code
  validates_uniqueness_of :sort, :scope => :familia_id

  belongs_to :supertaxon, :class_name => "Familia", :foreign_key => "familia_id"

  def to_param # overridden
    name_la.urlize
  end

end