class User::CommentsController < ApplicationController
  def index
    @article = Article.find params[:article_id]
    @comments = @article.comments
    @comment = Comment.new :article_hash_tag => @article.hash_tag
    respond_to do |format|
      format.html { render :partial => 'index' }
    end
  end

  def create
    @article = Article.find params[:comment][:article_id]
    params[:comment].delete :article_id
    @comment = Comment.new(params[:comment])
    @comment.article_hash_tag = @article.hash_tag

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
