class String
  def lat_humanize
    self.gsub(/_|\+/,' ').gsub(/ +/,' ').capitalize
  end

  def urlize
    self.gsub(' ','_').capitalize
  end

  def slav_humanize
    k = self.mb_chars.split
    #.capitalize.to_s
  end
end