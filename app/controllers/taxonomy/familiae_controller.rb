module Taxonomy

  class FamiliaeController < TaxaController

    class << self; attr_reader :rank_name, :model_class end

    @rank_name = controller_name.singularize
    @model_class = @rank_name.camelize.constantize
    
  end

end
