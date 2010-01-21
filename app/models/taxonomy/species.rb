class Species < Taxon

  validates_format_of :code, :with => /^[a-z]{6}$/
  validates_format_of :name_la, :with => /^[A-Z][a-z]+ [a-z]+$/
  validates_uniqueness_of :code

  child_of :familia

  def to_param
    name_la.urlize
  end
  
end