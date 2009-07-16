class Taxon < ActiveRecord::Base
  validates_presence_of :name_la, :name_ru, :name_uk, :sort
       
  def to_param  # overridden
    name_la
  end

end
