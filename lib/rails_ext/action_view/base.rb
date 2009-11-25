class ActionView::Base
  def model_name
    controller_name.singularize
  end
end