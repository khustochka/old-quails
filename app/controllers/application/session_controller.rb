module SessionController

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
    CONFIG[:open_access] ?
            true :
            authenticate_or_request_with_http_basic do |username, password|
              username == CONFIG[:admin_username] && Digest::SHA1.hexdigest(password) == CONFIG[:admin_password]
            end
  end
end