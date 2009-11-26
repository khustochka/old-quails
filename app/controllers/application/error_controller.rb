module ErrorController

  def public404
    render "application/public404", :layout => "public", :status => 404
  end

  def admin404
    if admin_login_success?
      render "application/admin404", :layout => "admin", :status => 404
    else
      public404
    end
  end

  private

  def rescue_action_in_public(exception) #:doc:
    public404
  end
end
