module ActiveRecord
  module SortedHierarchy

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def parent_for(association_id, options = {}, &extension)
        has_many(association_id, options, &extension)
        write_inheritable_hash :reflections, :children => read_inheritable_attribute(:reflections)[association_id]
        instance_methods.select{|m| m.include?(association_id.to_s)}.each do |method|
          alias_method method.sub(/#{association_id}/, "children"), method
        end
      end

      def child_of(association_id, options = {})
        belongs_to(association_id, options)
        write_inheritable_hash :reflections, :parent => read_inheritable_attribute(:reflections)[association_id]
        instance_methods.select{|m| m.include?(association_id.to_s)}.each do |method|
          alias_method method.sub(/#{association_id}/, "parent"), method
        end
      end

      def top_level?
        !read_inheritable_attribute(:reflections).has_key?(:parent)
      end

      def bottom_level?
        !read_inheritable_attribute(:reflections).has_key?(:children)
      end

      def parent_key
        unless top_level?
          assoc = read_inheritable_attribute(:reflections)[:parent]
          assoc.options[:foreign_key] || assoc.name.to_s.foreign_key 
        else
          nil
        end
      end
    end

    def insert_mind_sorting
      latest = (self.class.top_level? ? self.class.count : self.parent.children.size) + 1
      self.sort = latest if self.sort > latest || self.sort == 0
      conditions = ["sort >= #{self.sort}"]
      unless self.class.top_level?
        fk = self.class.parent_key
        conditions.push("#{fk} = #{self[fk]}")
      end
      self.class.transaction do
        self.class.update_all("sort = sort + 1", conditions.join(" AND "))
        save!
      end
    end

    def update_mind_sorting(attributes)
      latest = self.class.top_level? ? self.class.count : self.parent.children.size
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
          unless self.class.top_level?
            fk = self.class.parent_key
            conditions.push("#{fk} = #{self[fk]}")
          end
          self.class.update_all("sort = sort + (#{diff})", conditions.join(" AND "))
        end
        update_attributes!(attributes)
      end
    end

    def destroy_mind_sorting
      conditions = ["sort > #{self[:sort]}"]
      unless self.class.top_level?
        fk = self.class.parent_key
        conditions.push("#{fk} = #{self[fk]}")
      end
      self.class.transaction do
        destroy
        self.class.update_all("sort = sort - 1", conditions.join(" AND "))
      end
    end

  end
end