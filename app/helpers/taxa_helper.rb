module TaxaHelper
  def parent_row(item)
    content_tag( :tr, ( content_tag( :td, content_tag(:strong, link_to( item.name_la, item ), :colspan => 8 )))) + "\n"
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
      proceed_method, row_helper = proceed_methods.pop.to_a.first
      collection.each do |item|
        children = item.send(proceed_method)
        concat(send(row_helper, item))
        hierarchy_cells(children, proceed_methods.dup, &block)
      end
    end
  end

end