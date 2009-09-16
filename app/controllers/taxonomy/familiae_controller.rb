module Taxonomy

  class FamiliaeController < TaxaController

    def index
      redirect_to :controller => "ordines", :action => 'show', :id => params[:ordo_id]
    end


  end

end
