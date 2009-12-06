module SpeciesHelper
  def parent_row(item)
    content_tag( :tr, ( content_tag( :td, content_tag(:h2, link_to( item.name_la, url_for(item) )), :colspan => 8 ))) + "\n"
  end
end