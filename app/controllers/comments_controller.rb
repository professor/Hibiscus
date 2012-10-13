class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    #@post = post_type.find(params[:post_id])
    @post = post_type.find(params["#{post_type}_id".downcase.to_sym])
    @comment = @post.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to(@post, :notice => 'Thank you for your comment.')
    else
      redirect_to(@post, :flash => { :alert => 'Your comment could not be saved.' })
    end
  end

  def edit
    @post = post_type.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = post_type.find(params["#{post_type}_id".downcase.to_sym])
    @comment = @post.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to(@post, :notice => 'Thank you for the update in your comment.')
    else
      render :action => "edit"
    end
  end             

  ##
  # Delete an existing comment and generate a notice of whether it was deleted or not.
  def destroy
    @post = post_type.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to(posts_url, :notice => 'Your comment has been deleted') }
        format.xml  { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to(posts_url, :notice => "You can't delete someone else's comment") }
      end
    end
  end  
end
