class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @articles = []
    if user_signed_in?
      @articles_count = current_user.articles_count
      @starred_articles_count = current_user.starred_articles_count
    end
    @custom_title = 'Pick a channel'
  end

  def error_404
    flash[:alert] = 'Error 404: requested page not found.'
    redirect_to root_path
  end
end
