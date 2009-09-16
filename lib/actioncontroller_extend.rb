class ActionController::Base
  def model_name
    controller_name.singularize
  end

  def model_class
    model_name.camelize.constantize
  end
end

=begin

def layout(template_name, conditions = {}, auto = false)
  add_layout_conditions(conditions)
  write_inheritable_attribute(:layout, template_name)
  write_inheritable_attribute(:auto_layout, auto)
end

=end
