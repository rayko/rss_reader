class User::SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @articles = Article.search params[:search][:query]
    unless params[:search][:channel_id].blank?
      @articles.select!{ |article| article.channel_id == params[:search][:channel_id].to_i }
    end
    respond_to do |format|
      format.html { }
    end
  end

end
