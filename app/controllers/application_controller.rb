class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @articles = []
  end

  def error_404
    flash[:alert] = 'Error 404: requested page not found.'
    redirect_to root_path
  end
end
