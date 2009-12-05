#require 'grit'

class AdminController < ApplicationController

  layout "admin"

  before_filter :require_admin_auth, :only => :dashboard

  def dashboard
    reset_session
    #session= {:expire_after => 1.year.from_now.to_s} #TODO: how to set valid session expiration?
    session[CONFIG[:admin_session_ask].to_sym] = CONFIG[:admin_session_reply] unless CONFIG[:open_access]
    #redirect_to :controller => 'ordines', :action => 'index'

#    repo = Grit::Repo.new(Rails.root)
#    @head = repo.commits("master", 1).first
#
#    @last_commit = @head.id
#
#    status = repo.status
#
#    @is_clean = "Added: #{status.added.size}, changed: #{status.changed.size}, deleted: #{status.deleted.size}, untracked: #{status.untracked.size}"

    render "dashboard"
  end

end