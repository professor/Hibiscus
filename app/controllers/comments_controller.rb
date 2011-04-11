class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user
    
    if @comment.save
      redirect_to(@post, :notice => 'Thank you for your comment.')
    else
      redirect_to(@post, :flash => { :error => 'Your comment could not be saved.' })
    end
  end
  
  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to(@post, :notice => 'Thank you for the update in your comment.')
    else
      render :action => "edit"
    end
  end
end
