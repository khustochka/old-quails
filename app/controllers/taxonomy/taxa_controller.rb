module Taxonomy
  class TaxaController < ApplicationController

  helper_method :url_for

  before_filter :require_admin

  layout "admin"

  helper :taxa

  before_filter :find_taxon,  :only => [:show, :update, :destroy]
  before_filter :find_all_taxa,  :only => [:index, :new, :show]

  rescue_from ActiveRecord::RecordInvalid, :with => :rescue_invalid_record


  def index
    respond_to do |format|
      format.html { render 'taxa/index' } # index.html.erb
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
    @taxon = model_class.new(params[model_name.to_sym])

    respond_to do |format|
      @taxon.insert_mind_sorting
      flash[:notice] = "#{model_name.humanize} was successfully created."
      format.html { redirect_to @taxon, :action => 'edit' }
      #format.xml  { render :xml => @taxon, :status => :created, :location => @taxon }
    end
  end


  def update
    respond_to do |format|
      @taxon.update_mind_sorting(params[model_name.to_sym])
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

	def url_for(taxon)
	  super( taxon.respond_to?(:supertaxon) ? [taxon.supertaxon, taxon] : taxon )
	end

  private
    def find_taxon
      @taxon = model_class.find_by_name_la(params[:id])
      admin404 if @taxon.nil?
    end

    def find_all_taxa
      @taxa = (!@taxon.nil? && @taxon.respond_to?(:supertaxon)) ? @taxon.supertaxon.subtaxa : model_class.all(:order => "sort")  # todo: сомнительно
    end

    def rescue_invalid_record
      respond_to do |format|
        find_all_taxa
        format.html { render 'taxa/add_edit' }
        #format.xml  { render :xml => @taxon.errors, :status => :unprocessable_entity }
      end
    end
    
  end

end
