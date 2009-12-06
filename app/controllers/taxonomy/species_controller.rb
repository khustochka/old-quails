class SpeciesController < TaxaController
  def index
    respond_to do |format|
      format.html { render 'taxa/index', :layout => "public" }
      #format.xml  { render :xml => @taxa }
    end
  end
end