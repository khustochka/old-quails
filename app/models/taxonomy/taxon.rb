class Taxon < ActiveRecord::Base

  self.abstract_class = true

  validates_presence_of :name_la, :name_ru, :name_uk, :sort
  validates_uniqueness_of :name_la, :name_ru, :name_uk

  # Class methods

  def self.prepare_hierarchy
    proceed_methods = []
    initial_model = self
    eager_load = nil

    while initial_model.reflect_on_association(:supertaxon) do
      proceed_methods.push( {:subtaxa => :parent_row} )
      eager_load = eager_load.nil? ? :subtaxa : { :subtaxa => eager_load }
      initial_model = initial_model.reflect_on_association(:supertaxon).klass
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

  def insert_mind_sorting
    latest = (self.respond_to?(:supertaxon) ? self.supertaxon.subtaxa.count : self.class.count) + 1
    self.sort = latest if self.sort > latest || self.sort == 0
    conditions = ["sort >= #{self.sort}"]
    if self.respond_to?(:supertaxon)
      fk = self.supertaxon.class.to_s.foreign_key
      conditions.push("#{fk} = #{self[fk]}")
    end
    self.class.transaction do
      self.class.update_all("sort = sort + 1", conditions.join(" AND "))
      save!
    end
  end

  def update_mind_sorting(attributes)
    latest = self.respond_to?(:supertaxon) ? self.supertaxon.subtaxa.count : self.class.count
    current = attributes[:sort].to_i
    new_sort = attributes[:sort] =
            current > latest || current == 0 ?
                    latest :
                    current
    old_sort = self[:sort].to_i

    self.class.transaction do
      if new_sort != old_sort
        diff = (old_sort - new_sort) / (old_sort - new_sort).abs
        max_sort = [old_sort, new_sort - diff].max
        min_sort = [old_sort, new_sort - diff].min
        conditions = ["sort > #{min_sort}", "sort < #{max_sort}"]
        if self.respond_to?(:supertaxon)
          fk = self.supertaxon.class.to_s.foreign_key
          conditions.push("#{fk} = #{self[fk]}")
        end
        self.class.update_all("sort = sort + (#{diff})", conditions.join(" AND "))
      end
      update_attributes!(attributes)
    end
  end

  def destroy_mind_sorting
    conditions = ["sort > #{self[:sort]}"]
    if self.respond_to?(:supertaxon)
      fk = self.supertaxon.class.to_s.foreign_key
      conditions.push("#{fk} = #{self[fk]}")
    end
    self.class.transaction do
      destroy
      self.class.update_all("sort = sort - 1", conditions.join(" AND "))
    end
  end

end
