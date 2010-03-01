module ActiveRecord
  class Base
    def merge_conditions(*conditions)
      self.class.merge_conditions(*conditions)
    end
  end
end