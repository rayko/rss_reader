class User::ArticlesController < ApplicationController
  # Check Authentication

  def articles_list
    if params[:fetch] == 'all'
      @articles = Article.where :channel_id => params[:channel_id]
    else
      @articles = Article.where :channel_id => params[:channel_id], :read => false
    end
    @channel = Channel.find params[:channel_id]
    @unread_count = @articles.select{ |a| !a.read }.size
    respond_to do |format|
      format.html { render :partial => 'articles_list', :layout => false}
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
end
