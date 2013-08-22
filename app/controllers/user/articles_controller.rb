class User::ArticlesController < ApplicationController
  before_filter :authenticate_user!

  def index
    fetch_articles params
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
    @articles = current_user.all_articles.order('created_at ASC').page params[:page]
    @custom_title = 'Displaying all articles'
    set_counter_and_pagination
    respond_to do |format|
      format.html { render :partial => 'index', :layout => false}
    end
  end

  def starred
    @articles = current_user.starred_articles.order('created_at ASC').page params[:page]
    set_counter_and_pagination
    @custom_title = 'Starred articles'
    respond_to do |format|
      format.html { render :partial => 'index', :layout => false}
    end
  end

  private
  def set_counter_and_pagination
    @enable_pagination = true
    @unread_count = @articles.select{ |a| !a.read }.size
  end

  def fetch_articles options
    @articles = Article.get_articles(options).page options[:page]
    @channel = Channel.find options[:channel_id]
    @unread_count = @channel.unread_articles_count
    @enable_pagination = true
  end
end
