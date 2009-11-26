class Taxon < ActiveRecord::Base

  self.abstract_class = true # I've read the FM and got it!

  validates_presence_of :name_la, :name_ru, :name_uk, :sort
  validates_uniqueness_of :name_la, :name_ru, :name_uk

  def to_param # overridden
    name_la
  end

  def insert_mind_sorting
    self.class.transaction do
      self.class.update_all("sort = sort + 1", "sort >= #{self[:sort]}") # TODO: add verification of the parent id if necessary
      save!
    end
  end

  def update_mind_sorting(attributes)
    new_sort = attributes[:sort].to_i
    old_sort = self[:sort].to_i

    self.class.transaction do
      if new_sort != old_sort
        diff = (old_sort - new_sort) / (old_sort - new_sort).abs
        max_sort = [old_sort, new_sort - diff].max
        min_sort = [old_sort, new_sort - diff].min
        self.class.update_all("sort = sort + (#{diff})", "sort > #{min_sort} AND sort < #{max_sort}")
      end
      update_attributes!(attributes)
    end
  end

  def destroy_mind_sorting
    self.class.transaction do
      destroy
      self.class.update_all("sort = sort - 1", "sort > #{self[:sort]}")
    end
  end

end
