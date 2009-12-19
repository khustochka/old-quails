class TaxaController < ApplicationController

  class ArrayOfRecords < Array
    def nil_or_empty?
      self.nil? || self.empty?
    end

    def cleanup(proceed_methods)
      unless self.nil_or_empty? || proceed_methods.nil? || proceed_methods.empty?
        proceed_method = proceed_methods.pop.keys.first
        self.reject! do |item|
          children = ArrayOfRecords.new(item.send(proceed_method))
          children.cleanup(proceed_methods.dup)
          children.nil_or_empty?
        end
      end
    end
  end


#  helper_method :url_for # this is to use controller methods as helpers in views 


  before_filter :require_admin

  layout "admin"

  helper :taxa

  before_filter :find_taxon, :only => [:update, :destroy]
  before_filter :find_taxon_with_children, :only => :show
  before_filter :find_all_taxa, :only => [:new, :show]
  before_filter :prepare_hierarchy, :only => :index

  rescue_from ActiveRecord::RecordInvalid, :with => :rescue_invalid_record


  def index
    respond_to do |format|
      format.html { render 'taxa/index' }
      #format.xml  { render :xml => @taxa }
    end
  end


  def show
    render 'taxa/add_edit'
  end


  def new
    @taxon = model_class.new(:sort => @taxa.size+1)

    respond_to do |format|
      format.html { render 'taxa/add_edit' }
      #format.xml  { render :xml => @taxon }
    end
  end


  def edit
    redirect_to :action => "show"
  end


  def create
    @taxon = model_class.new(params[model_sym])

    respond_to do |format|
      @taxon.insert_mind_sorting
      flash[:notice] = "#{model_name.humanize} was successfully created."
      format.html { redirect_to @taxon, :action => 'edit' }
      #format.xml  { render :xml => @taxon, :status => :created, :location => @taxon }
    end
  end


  def update
    respond_to do |format|
      @taxon.update_mind_sorting(params[model_sym])
      flash[:notice] = "#{model_name.humanize} was successfully updated."
      format.html { redirect_to :action => "show", :id => @taxon }
      #format.xml  { head :ok }

    end
  end


  def destroy
    @taxon.destroy_mind_sorting

    respond_to do |format|
      format.html { redirect_to :action => "index" }
      #format.xml  { head :ok }
    end
  end

  private
  def find_taxon
    @taxon = model_class.find_by_name_la!(params[:id])
  end

  def find_taxon_with_children
    find_taxon
    @bunch = @taxon.subtaxa if @taxon.respond_to?(:subtaxa)
  end

  def find_all_taxa
    @proceed_methods = []
    @taxa = (!@taxon.nil? && @taxon.respond_to?(:supertaxon)) ? @taxon.supertaxon.subtaxa : model_class.all(:order => "sort")
  end

  def prepare_hierarchy
    @proceed_methods = []
    initial_model = model_class
    eager_load = nil

    until initial_model == Ordo do
      @proceed_methods.push( {:subtaxa => :parent_row} )
      eager_load = eager_load.nil? ? :subtaxa : { :subtaxa => eager_load }
      initial_model = initial_model.reflect_on_association(:supertaxon).klass
    end

    @bunch = ArrayOfRecords.new(Ordo.all(:order => "sort", :include => eager_load))
  end

  def rescue_invalid_record
    respond_to do |format|
      find_all_taxa
      format.html { render 'taxa/add_edit' }
      #format.xml  { render :xml => @taxon.errors, :status => :unprocessable_entity }
    end
  end

end
