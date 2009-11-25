module ActionView::Helpers

  class FormBuilder

    def set_sorting_combo(bunch, one, label_format = "sort number: {:sort}")
      select( :sort, [["At the beginning", 1]] + (bunch - [one]).map {|tx| [label_format.class.eql?(Symbol) ? tx[label_format] : label_format.gsub(/\{:([A-Za-z_]+)\}/) {|prp| tx[$1.to_sym]}, tx[:sort] + (tx[:sort] < one[:sort] ? 1 : 0)]} )
    end

    alias :original_method_missing :method_missing

    def method_missing(method_name, *args)
      if method_name.to_s.include?('labelled_')
        label(args[0]) + "\n<br />\n" + send(method_name.to_s.gsub(/labelled_(.*)/, '\1').intern, *(args[1].nil? ? args : args[1..-1]))
      else
        original_method_missing(method_name, *args)
      end
    end

  end

end