# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def inside_layout(layout, &block)
    layout = layout.include?('/') ? layout : "layouts/#{layout}"

    @template.instance_variable_set("@content_for_layout", capture(&block)) if block
    concat(@template.render(:file => layout, :user_full_path => true))
  end

  def counter_up(initial_value = 1)
    counter(initial_value, +1)
  end

  def counter_down(initial_value = 1)
    counter(initial_value, -1)
  end

  def counter(initial_value = 1, increment = 1)
    if @counter.nil?
      @counter = initial_value.kind_of?(Hash) ? initial_value[:start_at] : initial_value
    else
      @counter += increment
    end
  end

end
