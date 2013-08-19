class User::SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @articles = Article.search params[:search][:query]
    unless params[:search][:channel_id].blank?
      @articles.search params[:search][:query], :with => { :channel_id => params[:search][:channel_id].to_i }
    else
      @articles.search params[:search][:query]
    end
    @custom_title = "Results for #{params[:search][:query]}: #{@articles.size} items"
    respond_to do |format|
      format.html { }
    end
  end

end
