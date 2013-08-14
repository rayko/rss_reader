class User::ArticlesController < ApplicationController
  # Check Authentication

  def articles_list
    @articles = Article.where :channel_id => params[:channel_id]
    respond_to do |format|
      format.html { render :partial => 'articles_list', :layout => false}
    end
  end

  def mark_as_read
    @article = Article.find params[:id]
    unless @article.read
      @article.mark_as_read
    end
    respond_to do |format|
      format.json { render :json => :success}
    end
  end
end
