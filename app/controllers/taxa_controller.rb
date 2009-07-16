class TaxaController < ApplicationController
  
  def initialize
    super
    @rank_name = controller_name.singularize
    @model_class = @rank_name.camelize.constantize
  end

  attr_accessor :model_class, :rank_name

  before_filter :find_taxon,  :only => [:show, :edit, :update, :destroy]
  before_filter :find_all_taxa,  :only => [:index, :new, :edit]


  def index
    respond_to do |format|
      format.html { render 'taxa/index' } # index.html.erb
      #format.xml  { render :xml => @taxa }
    end
  end


  def show
    redirect_to :action => "edit"
  end


  def new
    @taxon = @model_class.new

    respond_to do |format|
      format.html { render 'taxa/edit' }
      #format.xml  { render :xml => @taxon }
    end
  end


  def edit
    render 'taxa/edit'
  end


  def create
    @taxon = @model_class.new(params[@rank_name.to_sym])

    respond_to do |format|
      @model_class.update_all("sort = sort + 1", "sort >= #{@taxon[:sort]}")
      if @taxon.save
        flash[:notice] = "<p class=\"notice\">#{@rank_name.humanize} was successfully created.</p>"
        format.html { redirect_to @taxon, :action => 'edit' }
        #format.xml  { render :xml => @taxon, :status => :created, :location => @taxon }
      else
        @model_class.update_all("sort = sort - 1", "sort > #{@taxon[:sort]}")
        find_all_taxa
        format.html { render 'taxa/edit' }
        #format.xml  { render :xml => @taxon.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      new_sort = params[@rank_name.to_sym][:sort].to_i
      old_sort = @taxon[:sort].to_i
      
      if @model_class.transaction do
            if new_sort != old_sort
              diff = (old_sort - new_sort) / (old_sort - new_sort).abs
              max_sort = [old_sort, new_sort - diff].max
              min_sort = [old_sort, new_sort - diff].min
              @model_class.update_all("sort = sort + (#{diff})", "sort > #{min_sort} AND sort < #{max_sort}")
            end
            @taxon.update_attributes(params[@rank_name.to_sym])
          end

        flash[:notice] = "<p class=\"notice\">#{@rank_name.humanize} was successfully updated.</p>"


        format.html { redirect_to :action => "edit" }
        #format.xml  { head :ok }
      else

        #@model_class.connection.rollback_db_transaction if new_sort != old_sort
        find_all_taxa
        format.html { render 'taxa/edit' }
        #format.xml  { render :xml => @taxon.errors, :status => :unprocessable_entity }
        
      end
    end
  end

  
  def destroy
    @model_class.update_all("sort = sort - 1", "sort > #{@taxon[:sort]}")
    @taxon.destroy

    respond_to do |format|
      format.html { redirect_to :action => "index" }  
      #format.xml  { head :ok }
    end
  end

  def sort_select_options
    [["At the beginning", 1]] + (@taxa - [@taxon]).map {|tx| ["#{tx[:name_la]} / #{tx[:name_ru]}", tx[:sort] + (@taxon[:sort].nil? ? 1 : (tx[:sort] < @taxon[:sort] ? 1 : 0))]}
  end

  private
    def find_taxon
      @taxon = @model_class.find_by_name_la(params[:id])
    end

    def find_all_taxa
      @taxa = @model_class.all(:order => "sort")
    end

end
