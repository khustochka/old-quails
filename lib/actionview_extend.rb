class ActionView::Base
  def model_name
    controller_name.singularize
  end 
end

module ActionView::Helpers

    class FormBuilder

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