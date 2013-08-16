class User::CommentsController < ApplicationController
  def index
    @comments = Comment.where :article_id => params[:article_id]
    @article = Article.find params[:article_id]
    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end

  def create
    @comment = Comment.new(params[:comment])
    @article = Article.find params[:comment][:article_id]
    respond_to do |format|
      if @article.belongs_to_user(current_user) && @comment.save
        current_user.comments << @comment
        format.html {  render :partial => 'comment', :locals => {:comment => @comment} }
        format.json { render json: @comment, status: :created }
      else
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end


end
