class ActionController::Base
  def model_name
    controller_name.singularize
  end

  def model_class
    model_name.camelize.constantize
  end
end