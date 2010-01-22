class Object
  def if_present(value = nil, &block)
    unless self.blank?
      if block_given?
        yield self
      elsif !value.nil?
        value
      else
        self
      end
    else
      self
    end
  end

  def if_present!(value = nil, &block)
    result = if_present(value, &block)
    if result.blank?
      raise(Standard Error, "Object is nil or blank.")
    else
      result
    end
  end
end