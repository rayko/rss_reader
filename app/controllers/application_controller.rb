class ApplicationController < ActionController::Base
  layout :layout_by_user_presence
  protect_from_forgery

  def index
    @articles = []
    if user_signed_in?
      @articles_count = current_user.articles_count
      @starred_articles_count = current_user.starred_articles_count
      @custom_title = 'Pick a channel'
    else
      redirect_to new_user_session_url, :layout => 'guest'
    end

  end

  def error_404
    flash[:alert] = 'Error 404: requested page not found.'
    redirect_to root_path
  end

  protected
  def layout_by_user_presence
    if devise_controller?
      'guest'
    else
      'application'
    end
  end
end
