module TaxaHelper

  def weave_table(collection, options = {}, &block)
    concat("Success!")
  end

  def hierarchy_cells(collection, proceed_methods = [], &block)
    if collection.nil? || collection.empty?
      concat(content_tag( :tr, ( content_tag( :td, "No records", :colspan => 8 ))))
    elsif proceed_methods.nil? || proceed_methods.empty?
      collection.each do |item|
        yield item
      end
    else
      proceed_method = proceed_methods.pop
      collection.each do |item|
        children = item.send(proceed_method)
#        unless children.nil? || children.empty?
          concat(content_tag( :tr, ( content_tag( :td, content_tag(:strong, link_to( item.name_la, url_for(item) )), :colspan => 8 ))))
          hierarchy_cells(children, proceed_methods.dup, &block)
#       end
      end
    end
  end

end