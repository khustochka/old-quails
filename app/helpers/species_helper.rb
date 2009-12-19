module SpeciesHelper
  def parent_row(item)
    content_tag( :tr, ( content_tag( :td, content_tag( :h2, item.name_la ), :colspan => 8 ))) + "\n"
  end
end