class ActionController::Base
  def model_name
    controller_name.singularize
  end

  def model_sym
    model_name.to_sym
  end

  def model_class
    controller_name.classify.constantize
  end
end