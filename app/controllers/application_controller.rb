# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  #helper :all # include all helpers, all the time # TODO: uncomment if some helper not working

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :require_admin_auth, :only => :admin_login

    def public404
        render "application/public404", :layout => "public", :status => 404
    end

    def admin404
      if admin?
        render "application/admin404", :layout => "admin", :status => 404 
      else
        public404
      end
    end

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
      if ENV['RAILS'].eql?('production')
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

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
