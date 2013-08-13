class User::ArticlesController < ApplicationController
  # Check Authentication

  def articles_list
    @articles = Article.where :channel_id => params[:channel_id]
  end
end
