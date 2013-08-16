class User::SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @articles = Article.search params[:search]
    # what to do next?
  end

end
