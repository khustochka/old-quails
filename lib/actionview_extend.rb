module ActionView::Helpers

    class FormBuilder
      def set_sorting_combo(bunch, one, label_format = "sort number: {:sort}")
        select( :sort, [["At the beginning", 1]] + (bunch - [one]).map {|tx| [label_format.class.eql?(Symbol) ? tx[label_format] : label_format.gsub(/\{:([A-Za-z_]+)\}/) {|prp| tx[$1.to_sym]}, tx[:sort] + (tx[:sort] < one[:sort] ? 1 : 0)]} )
      end

      def method_missing(method_name, *args)
        if method_name.to_s.include?('labelled_')
          args2 = args[1].nil? ? args : args[1..-1]
          label(args[0]) + "\n<br />\n" + send(method_name.to_s.gsub(/labelled_(.*)/, '\1').intern, *args2)
        end
      end
    end

    module CaptureHelper
      def inside_layout(layout, &block)
          layout = layout.include?('/') ? layout : "layouts/#{layout}"

          @template.instance_variable_set("@content_for_layout", capture(&block))
          concat(@template.render(:file => layout, :user_full_path => true), block.binding)
      end

    end

end