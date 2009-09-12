# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  #helper :all # include all helpers, all the time # TODO: uncomment if some helper not working

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

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
  
  private
    def require_admin
      public404 if !admin?
    end

    def admin?
      true
    end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
