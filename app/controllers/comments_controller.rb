class CommentsController < ApplicationController
  before_filter :authenticate_user!, :load_commentable

  def create
    @comment = @commentable.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to(@commentable, :notice => 'Thank you for your comment.')
    else
      redirect_to(@commentable, :flash => { :alert => 'Your comment could not be saved.' })
    end
  end

  def edit
    @comment = @commentable.comments.find(params[:id])
  end

  def update
    @comment = @commentable.comments.find(params[:id])
    if @comment.update_attributes(params[:comment])
      redirect_to(@commentable, :notice => 'Thank you for the update in your comment.')
    else
      render :action => "edit"
    end
  end             
  
  def destroy
    @comment = @commentable.comments.find(params[:id])
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
  def load_commentable
    # the url will be like: "/katas/kata-title/comments/5078b2b5f1d37f2a3a000064"
    resource, id = request.path.split('/')[1, 2]  # retrieve the 2nd and 3rd element in the url
    @commentable = resource.singularize.classify.constantize.find(id)   # find the right post/kata the comment belongs to
  end
end
