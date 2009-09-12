class Taxon < ActiveRecord::Base
  validates_presence_of :name_la, :name_ru, :name_uk, :sort
       
  def to_param  # overridden
    name_la
  end

  def insert_mind_sorting
    if save
      self.class.update_all("sort = sort + 1", "sort >= #{self[:sort]} AND id <> #{self.id}") # TODO: add verification of the parent id if necessary
    else
      false
    end
  end

  def update_mind_sorting(attributes)
    new_sort = attributes[:sort].to_i
    old_sort = self[:sort].to_i

    if update_attributes(attributes)
      if new_sort != old_sort
        diff = (old_sort - new_sort) / (old_sort - new_sort).abs
        max_sort = [old_sort, new_sort - diff].max
        min_sort = [old_sort, new_sort - diff].min
        self.class.update_all("sort = sort + (#{diff})", "sort > #{min_sort} AND sort < #{max_sort} AND id <> #{self.id}")
      end
    else
      false
    end
  end

  def destroy_mind_sorting
    if destroy
      self.class.update_all("sort = sort - 1", "sort > #{self[:sort]}")
    else
      false
    end
  end

end
