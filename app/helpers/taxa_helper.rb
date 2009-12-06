module TaxaHelper
  def parent_row(item)
    content_tag( :tr, ( content_tag( :td, content_tag(:strong, link_to( item.name_la, url_for(item) )), :colspan => 8 ))) + "\n"
  end

  def no_data_row
    content_tag( :tr, ( content_tag( :td, "No records", :colspan => 8 ))) + "\n"
  end

  def hierarchy_cells(collection, proceed_methods = [], &block)
    if collection.nil? || collection.empty?
      concat(no_data_row)
    elsif proceed_methods.nil? || proceed_methods.empty?
      collection.each do |item|
        yield item
      end
    else
      proceed_method = row_helper = nil
      proceed_methods.pop.each_pair do |key, value|
        proceed_method = key
        row_helper = value
      end
      collection.each do |item|
        children = item.send(proceed_method)
#        unless children.nil? || children.empty?
          concat(send(row_helper, item))
          hierarchy_cells(children, proceed_methods.dup, &block)
#       end
      end
    end
  end

end