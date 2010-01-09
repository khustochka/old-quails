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
      raise
    end
  end
end