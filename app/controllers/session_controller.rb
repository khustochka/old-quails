module SessionController

    def admin_login
      reset_session
      #session= {:expire_after => 1.year.from_now.to_s} #TODO: how to set valid session expiration?
      session[:yediat] = "li-koshki-moshek?"
      #redirect_to :controller => 'taxonomy/ordines', :action => 'index'
      render :text => Time.now().to_s
    end

  private
    def require_admin
      public404 if !admin?
    end

    def admin?
      if ENV['RAILS_ENV'].eql?('production')
        admin_session? && require_admin_auth
      else
        true
      end
    end

    def admin_session?
      session[:yediat].eql?("li-koshki-moshek?")
    end

    def require_admin_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == ADMIN['USER'] &&  Digest::SHA1.hexdigest(password) == ADMIN['PASSWORD']
      end
    end
end