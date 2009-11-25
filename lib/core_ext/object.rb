class Object

  def if_true(positive, negative = '')
    self ? positive.gsub(/\%s/, self) : negative
  end

end