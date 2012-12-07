# FlagsController handles creation, and listing of content flags.

class FlagsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  # List all existing flags.
  def index
    @flags = Flag.all.desc(:updated_at)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @flags }
    end
  end

  # Create a new flag. Record the content ID, and the ID of the user that reports the content.
  def create
    @flag = Flag.new

    if params[:comment_id]
      @post =Post.find(params[:post_id])
      @comment = @post.comments.find(params[:comment_id])
      @flag.comment = @comment
      @content = @post
    elsif params[:review_id]
      @kata = Kata.find(params[:post_id])
      @review = @kata.reviews.find(params[:review_id])
      @flag.review = @review
      @content = @kata
    elsif  params[:post_type] == "Post"
      @post = Post.find(params[:post_id])
      @flag.post = @post
      @content = @post
    elsif params[:post_type] == "Kata"
      @kata = Kata.find(params[:post_id])
      @flag.kata = @kata
      @content = @kata
    end

    @flag.user = current_user

    respond_to do |format|
      if @flag.save
        format.html { redirect_to(@content, :notice => 'You reported this content.') }
        format.xml { render :xml => @flag, :status => :created, :location => @flag }
      else
        format.html { redirect_to(root_path, :alert => "Your report could not be recorded. Errors: #{@flag.errors}") }
        format.xml { render :xml => @flag.errors, :status => :unprocessable_entity }
      end
    end
  end
end
