module ActionView::Helpers

  class FormBuilder

    def set_sorting_combo(bunch, one, &block)
      select( :sort, [["At the beginning", 1]] + (bunch - [one]).map {|tx| [block_given? ? (yield tx) : "sort number: #{tx[:sort]}", tx[:sort] + (one.new_record? || tx[:sort] < one[:sort] ? 1 : 0)]} )
    end

    alias :original_method_missing :method_missing

    def method_missing(method_name, *args, &block)
      if method_name.to_s.include?('labelled_')
        label(args[0]) + "\n<br />\n" + send(method_name.to_s.gsub(/labelled_(.*)/, '\1').intern, *(args[1].nil? ? args : args[1..-1]), &block)
      else
        original_method_missing(method_name, *args)
      end
    end

  end

end