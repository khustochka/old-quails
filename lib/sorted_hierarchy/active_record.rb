module SortedHierarchy
  module ActiveRecord 

    def self.included(klass)
      klass.extend ClassMethods
      klass.validate :correctness_of_sort_value
      klass.before_create :give_way_to_create
      klass.after_destroy :fix_gap_after_destroy
    end

    module ClassMethods

      def parent_for(association_id, options = {}, &extension)
        has_many(association_id, options, &extension)
        write_inheritable_hash :reflections, :children => read_inheritable_attribute(:reflections)[association_id]
        instance_methods.select{|m| m.include?(association_id.to_s)}.each do |method|
          alias_method method.sub(/#{association_id}/, "children"), method
        end
        instance_methods.select{|m| m.include?(association_id.to_s.singularize)}.each do |method|
          alias_method method.sub(/#{association_id.to_s.singularize}/, "child"), method
        end
      end

      def child_of(association_id, options = {})
        belongs_to(association_id, options)
        write_inheritable_hash :reflections, :parent => read_inheritable_attribute(:reflections)[association_id]
        instance_methods.select{|m| m.include?(association_id.to_s)}.each do |method|
          alias_method method.sub(/#{association_id}/, "parent"), method
        end
      end

      def set_sort_column(value)
        write_inheritable_attribute(:sort_column, value.to_sym)
      end

      def get_sort_column
        read_inheritable_attribute(:sort_column) || :sort
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
        end
      end

      def parent_class
        reflect_on_association(:parent).klass
      end
    end

    def get_sort_column
      self.class.get_sort_column
    end

    def top_level?
      self.class.top_level?
    end

    def bottom_level?
      self.class.bottom_level?
    end

    def update_mind_sorting(attributes)
      latest = self.top_level? ? self.class.count : self.parent.children.size
      current = attributes[get_sort_column].to_i
      new_sort = attributes[get_sort_column] = latest if current.nil?
      old_sort = self[get_sort_column].to_i

      self.class.transaction do
        if new_sort != old_sort
          diff = (old_sort - new_sort) / (old_sort - new_sort).abs
          max_sort = [old_sort, new_sort - diff].max
          min_sort = [old_sort, new_sort - diff].min
          conditions = ["#{get_sort_column} > #{min_sort}", "#{get_sort_column} < #{max_sort}"]
          conditions.push(scope_condition) unless self.top_level?
          self.class.update_all("#{get_sort_column} = #{get_sort_column} + (#{diff})", conditions.join(" AND "))
        end
        update_attributes!(attributes)
      end
    end

    private
    def scope_condition
      fk = self.class.parent_key
      "#{fk} = #{self[fk]}"
    end

    def correctness_of_sort_value
      raw_value = send("#{get_sort_column}_before_type_cast")
      unless raw_value.nil?
        unless raw_value.to_s =~ /\A[+-]?\d+\Z/
          errors.add(get_sort_column, :not_a_number, :value => raw_value)
        else
          latest = (self.top_level? ? self.class.count : self.parent.children.size) + (new_record? ? 1 : 0)
          if self[get_sort_column] > latest
            errors.add(get_sort_column, :less_than_or_equal_to, :value => raw_value, :count => latest)
          end
        end
      end
    end

    def give_way_to_create
      latest = (self.top_level? ? self.class.count : self.parent.children.size) + 1
      self[get_sort_column] ||= latest
      if self[get_sort_column] < latest
        conditions = ["#{get_sort_column} >= #{self[get_sort_column]}"]
        conditions.push(scope_condition) unless self.top_level?
        self.class.update_all("#{get_sort_column} = #{get_sort_column} + 1", conditions.join(" AND "))
      end
    end

    def fix_gap_after_destroy
      conditions = ["#{get_sort_column.to_s} > #{self[get_sort_column]}"]
      conditions.push(scope_condition) unless self.top_level?
      self.class.update_all("#{get_sort_column} = #{get_sort_column} - 1", conditions.join(" AND "))
    end

  end
end