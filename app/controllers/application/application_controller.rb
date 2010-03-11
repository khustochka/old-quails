# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include ErrorController
  include SessionController

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password

  before_filter :set_locale

  private
  def set_locale
    I18n.locale = non_default_locales.include?(params[:hl]) ? params[:hl] : I18n.default_locale
#    I18n.reload!
  end

  def default_url_options(options={})
    { :hl => I18n.locale } if non_default_locales.include?(I18n.locale)
  end

  def non_default_locales
    %w(en uk ru) - [I18n.default_locale.to_s]
  end
end
