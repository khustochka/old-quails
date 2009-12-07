class RootController < ApplicationController
  def root
    redirect_to :controller => :species, :action => :index
  end
end