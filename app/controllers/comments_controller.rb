class CommentsController < ApplicationController
  before_filter :authenticate_user!, :load_commentable, :load_commentable_collection

  ##
  # Create a new comment that belongs to a user and a post,
  # and generate a notice of whether the comment could be saved or not.
  def create
    #@comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to(@commentable, :notice => 'Thank you for your comment.')
    else
      redirect_to(@commentable, :flash => { :alert => 'Your comment could not be saved.' })
    end
  end

  ##
  # Retrieve a comment to edit.
  def edit
    #@comment = @commentable.comments.find(params[:id])
  end

  ##
  # Update a comment, and generate a notice if the changes could be saved or retry to edit otherwise.
  def update
    #@comment = @commentable.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to(@commentable, :notice => 'Thank you for the update in your comment.')
    else
      render :action => "edit"
    end
  end

  ##
  # Delete an existing comment and generate a notice of whether it was deleted or not.
  def destroy
    #@comment = @commentable.comments.find(params[:id])
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

private
  # preload the variable @post that the current comment belongs to
  def load_commentable
    # the request url will be in this format: "/katas/kata-title/comments/5078b2b5f1d37f2a3a000064"
    resource, id = request.path.split('/')[1, 2]  # retrieve the 2nd and 3rd element in the url
    @commentable = resource.classify.constantize.find(id)   # find the right post/kata the comment belongs to
  end

  def load_commentable_collection
    if @commentable.is_a?(Kata)
      @comment = @commentable.reviews.build(params[:comment])
    else
      @comment = @commentable.comments.build(params[:comment])
    end
  end
end