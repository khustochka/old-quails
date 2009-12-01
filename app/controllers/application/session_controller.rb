module SessionController

  def admin_login
    reset_session
    #session= {:expire_after => 1.year.from_now.to_s} #TODO: how to set valid session expiration?
    session[CONFIG[:admin_session_ask].to_sym] = CONFIG[:admin_session_reply]
    #redirect_to :controller => 'ordines', :action => 'index'
    render :text => Time.zone.now().to_s
  end

  private
  def require_admin
    public404 unless admin_login_success?
  end

  def admin_login_success?
    CONFIG[:open_access] ?
            true :
            admin_session? && require_admin_auth
  end

  def admin_session?
    session[CONFIG[:admin_session_ask].to_sym] == CONFIG[:admin_session_reply]
  end

  def require_admin_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == CONFIG[:admin_username] && Digest::SHA1.hexdigest(password) == CONFIG[:admin_password]
    end
  end
end