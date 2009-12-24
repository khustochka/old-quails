class String
  def lat_humanize
    self.gsub(/_|\+/, ' ').gsub(/ +/, ' ').capitalize
  end

  def urlize
    self.gsub(' ', '_').capitalize
  end

  def slav_humanize
    full_name = self.split
    full_name.push(full_name.shift)
    full_name.join(" ").mb_chars.capitalize.to_s
  end

  def if_not_empty(mask, else_option = '')
    self.empty? ? else_option : mask.gsub(/\%s/, self)
  end
end