class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @articles = Article.all
    @channels = current_user.channels
    @channel = Channel.new
    @channel_path = user_channels_path
  end
end
