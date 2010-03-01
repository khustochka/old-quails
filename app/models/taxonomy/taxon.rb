class Taxon < ActiveRecord::Base

  include SortedHierarchy::ActiveRecord

  self.abstract_class = true

  validates_presence_of :name_la, :name_ru, :name_uk
  validates_uniqueness_of :name_la, :name_ru, :name_uk

  # Class methods

  def self.prepare_hierarchy
    proceed_methods = []
    initial_model = self
    eager_load = nil

    until initial_model.top_level? do
      proceed_methods.push( {:children => :parent_row} )
      eager_load = eager_load.nil? ? :children : { :children => eager_load }
      initial_model = initial_model.parent_class
    end

    [initial_model.all(:include => eager_load, :order => "sort"),
     proceed_methods]
  end

  # Instance methods

  def to_param
    name_la
  end

  def name
    send("name_#{I18n.locale}")
  end

end
