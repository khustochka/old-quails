# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def inside_layout(layout, &block)
      layout = layout.include?('/') ? layout : "layouts/#{layout}"

      @template.instance_variable_set("@content_for_layout", capture(&block)) if block
      concat(@template.render(:file => layout, :user_full_path => true))
  end

end
