class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @articles = []
  end
end
