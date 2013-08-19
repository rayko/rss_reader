class User::SearchController < ApplicationController
  before_filter :authenticate_user!

  def search
    @articles = Article.search params[:search][:query], :page => params[:page]
    unless params[:search][:channel_id].blank?
      @articles.search params[:search][:query], :with => { :channel_id => params[:search][:channel_id].to_i }, :page => params[:page]
    else
      @articles.search params[:search][:query], :page => params[:page]
    end
    @enable_pagination = true
    @custom_title = "Results for #{params[:search][:query]}: #{@articles.total_entries} items"
    respond_to do |format|
      format.html { }
    end
  end

end
