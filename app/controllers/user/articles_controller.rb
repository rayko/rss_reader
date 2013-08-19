class User::ArticlesController < ApplicationController

  before_filter :authenticate_user!

  def index
    if params[:fetch] == 'all'
      @articles = Article.where(:channel_id => params[:channel_id]).order(:created_at).page params[:page]
    else
      @articles = Article.where(:channel_id => params[:channel_id], :read => false).order(:created_at).page params[:page]
    end
    @channel = Channel.find params[:channel_id]
    @unread_count = @articles.select{ |a| !a.read }.size
    @enable_pagination = true
    respond_to do |format|
      format.html { render :partial => 'index', :layout => false}
    end
  end

  def mark_as_read
    @article = Article.find params[:id]
    marked = false
    unless @article.read
      marked = @article.mark_as_read
    end
    respond_to do |format|
      format.json { render :json => marked ? :success : :already_marked }
    end
  end

  def mark_all
    @articles = Article.where :channel_id => params[:channel_id], :read => false
    @articles.each do |article|
      article.update_attribute :read, true
    end
    respond_to do |format|
      format.json { render :json => :success }
    end
  end

  def toggle_starred
    @article = Article.find params[:id]
    if @article
      @article.toggle_starred
    end
    respond_to do |format|
      format.json { render :json => :success }
    end
  end

  def full_list
    @articles = current_user.all_articles.order(:created_at).page params[:page]
    @unread_count = @articles.select{ |a| !a.read }.size
    @custom_title = 'Displaying all articles'
    @enable_pagination = true
    respond_to do |format|
      format.html { render :partial => 'index', :layout => false}
    end
  end

  def starred
    @articles = current_user.starred_articles.order(:created_at).page params[:page]
    @unread_count = @articles.select{ |a| !a.read }.size
    @custom_title = 'Starred articles'
    @enable_pagination = true
    respond_to do |format|
      format.html { render :partial => 'index', :layout => false}
    end
  end
end
