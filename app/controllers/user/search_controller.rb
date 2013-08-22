class User::SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @articles = Article.perform_search :query => params[:search][:query], :channel_id => params[:search][:channel_id], :page => params[:page]
    @enable_pagination = true
    @custom_title = "Results for #{params[:search][:query]}: #{@articles.total_entries} items"
    respond_to do |format|
      format.html { }
    end
  end

end
