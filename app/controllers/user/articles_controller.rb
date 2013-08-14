class User::ArticlesController < ApplicationController
  # Check Authentication

  def articles_list
    @articles = Article.where :channel_id => params[:channel_id]
    respond_to do |format|
      format.html { render :partial => 'articles_list', :layout => false}
    end
  end
end
