# CommentsController handles model and view for Comment, and Review. It determines the types of
# of the comment resource (Post or Kata) and the comment (Comment or Review) by parsing the html
# request path.

class CommentsController < ApplicationController
  before_filter :authenticate_user!, :load_commentable, :load_commentable_collection
  before_filter :select_comment_symbol, :only => [:create, :update]

  ##
  # Create a new comment that belongs to a user and a post,
  # and generate a notice of whether the comment could be saved or not.
  def create
    @comment = @commentable_collection.build(params[@comment_symbol])
    @comment.user = current_user
    if @comment.save
      current_user.add_points(5)
      redirect_to(@commentable, :notice => "Thank you for your #{@comment.class.to_s.downcase}.")
    else
      if @comment.errors.any?
        @comment_errors_message = "#{controller_text_helper.pluralize(@comment.errors.count, "error")} prohibited this #{@comment.class.to_s.downcase} from being saved:\n"
        @comment_errors_message << "\n"
        @comment.errors.full_messages.each do |msg|
          @comment_errors_message << msg << "; "
        end
      end
      redirect_to(@commentable, :flash => {:alert => "Your #{@comment.class.to_s.downcase} could not be saved.", :error => "#{@comment_errors_message}"})
    end
  end

  ##
  # Retrieve a comment to edit.
  def edit
    @comment = @commentable_collection.find(params[:id])
    authorize! :update, @comment
  end

  ##
  # Update a comment, and generate a notice if the changes could be saved or retry to edit otherwise.
  def update
    @comment = @commentable_collection.find(params[:id])
    authorize! :update, @comment
    if @comment.update_attributes(params[@comment_symbol])
      redirect_to(@commentable, :notice => "Thank you for the update in your #{@comment.class.to_s.downcase}.")
    else
      render :action => "edit"
    end
  end

  ##
  # Delete an existing comment and generate a notice of whether it was deleted or not.
  def destroy
    @comment = @commentable_collection.find(params[:id])
    authorize! :destroy, @comment
    if  @comment.destroy
      respond_to do |format|
        format.html { redirect_to(@commentable, :notice => "Your #{@comment.class.to_s.downcase} has been deleted") }
        format.xml { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to(@commentable, :alert => "Your #{@comment.class.to_s.downcase} could not be deleted.") }
      end
    end
  end

  # Vote up for a comment(of posts), or a review(of kata).
  def upvote
    @voteable = @commentable_collection.find(params[:id])
    current_user.vote_for(@voteable)
    current_user.add_points(1)
    @voteable.update_vote_score
    respond_to do |format|
      format.js
    end
  end

  # Vote down for a comment(of posts), or a review(of kata).
  def downvote
    @voteable = @commentable_collection.find(params[:id])
    current_user.vote_against(@voteable)
    current_user.add_points(1)
    @voteable.update_vote_score
    respond_to do |format|
      format.js
    end
  end

  private
  # preload the variable @post that the current comment belongs to
  def load_commentable
    # the request url will be in this format: "/katas/kata-title/comments/5078b2b5f1d37f2a3a000064"
    resource, id = request.path.split('/')[1, 2] # retrieve the 2nd and 3rd element in the url
    @commentable = resource.classify.constantize.find_by_slug(id) # find the right post/kata the comment belongs to
  end

  ##
  # Retrieve the collection of comments/reviews of the post/kata the current comment belongs to.
  def load_commentable_collection
    if @commentable.is_a?(Kata)
      @commentable_collection = @commentable.reviews
    else
      @commentable_collection = @commentable.comments
    end
  end

  ##
  # Helper method to provide the symbol of the current comment's class.
  def select_comment_symbol
    if @commentable.is_a?(Kata)
      @comment_symbol = :review
    else
      @comment_symbol = :comment
    end
  end

end