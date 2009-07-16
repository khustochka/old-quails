class FamiliaeController < TaxaController
  def initialize
    super
    @model_class = Familia
    @rank_name = "familia"
  end

  attr_accessor :model_class, :rank_name
end
