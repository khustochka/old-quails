module TaxaHelper

  def weave_table(collection, options = {}, &block)
    concat("Success!")
  end

end

module ActionView::Helpers
    class FormBuilder
      def set_sorting_combo(bunch, one, label_format = "sort number: {:sort}")
        select( :sort, [["At the beginning", 1]] + (bunch - [one]).map {|tx| [label_format.class.eql?(Symbol) ? tx[label_format] : label_format.gsub(/\{:([A-Za-z_]+)\}/) {|prp| tx[$1.to_sym]}, tx[:sort] + (tx[:sort] < one[:sort] ? 1 : 0)]} )
      end
    end
end