class SpeciesController < TaxaController

  skip_before_filter :require_admin, :only => [:index, :show]

  before_filter :find_taxon, :only => [:edit, :update, :destroy]
  before_filter :find_all_taxa, :only => [:new, :show, :edit]

  def index
    respond_to do |format|
      format.html { render 'index', :layout => "public" }
      #format.xml  { render :xml => @taxa }
    end
  end

  def show
    render :layout => "panned"
  end


  def edit
    render 'taxa/add_edit'
  end

  private
  def find_taxon
    human_name = params[:id].lat_humanize
    @taxon = model_class.find_by_name_la!(human_name)
    redirect_to @taxon, :status => 301 if @taxon.name_la.urlize != params[:id] 
  end

  def prepare_hierarchy
    super
    @bunch.cleanup(@proceed_methods.dup)
  end
  
end
