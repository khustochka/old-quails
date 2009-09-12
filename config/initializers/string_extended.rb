class String
  def lat_humanize
    self.gsub(/_|\+/,' ').gsub(/ +/,' ').capitalize
  end

  def urlize
    self.gsub(' ','_').capitalize
  end

  #def slav_humanize
  #  (self.sub(/^(.+) ([^ ]+)$/) {|match| "\2 \1"}).capitalize
  #end
end