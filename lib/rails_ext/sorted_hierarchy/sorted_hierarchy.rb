module ActiveRecord
  module SortedHierarchy

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def parent_for(association_id, options = {}, &extension)
        has_many(association_id, options, &extension)
        write_inheritable_attribute(:children_assoc, association_id)
      end

      def child_of(association_id, options = {})
        belongs_to(association_id, options)
        write_inheritable_attribute(:parent_assoc, association_id)
      end

      def children_assoc
        read_inheritable_attribute(:children_assoc)
      end

      def parent_assoc
        read_inheritable_attribute(:parent_assoc)
      end

    end

  end
end