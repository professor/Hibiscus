class FlagsController < ApplicationController
  # GET /flags
  # GET /flags.xml
  def index
    @flags = Flag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @flags }
    end
  end

  # POST /flags
  # POST /flags.xml
  def create
    @flag = Flag.new

    if params[:comment_id]
      @comment = Post.find(params[:post_id]).comments.find(params[:comment_id])
      @flag.comment = @comment
    elsif params[:review_id]
      @review = Kata.find(params[:post_id]).reviews.find(params[:review_id])
      @flag.review = @review
    elsif  params[:post_type] == "Post"
      @post = Post.find(params[:post_id])
      @flag.post = @post
    elsif  params[:post_type] == "Article"
      @post = Post.find(params[:post_id])
      @flag.post = @post
    elsif params[:post_type] == "Kata"
      @kata = Kata.find(params[:post_id])
      @flag.kata = @kata
    end

    @flag.user = current_user

    respond_to do |format|
      if @flag.save
        format.html { redirect_to(flags_path, :notice => 'Flag was successfully created.') }
        format.xml { render :xml => @flag, :status => :created, :location => @flag }
      else
        format.html { redirect_to(flags_path, :alert => 'Flag was not created.') }
        format.xml { render :xml => @flag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flags/1
  # DELETE /flags/1.xml
  def destroy
    @flag = Flag.find(params[:id])
    @flag.destroy

    respond_to do |format|
      format.html { redirect_to(flags_url) }
      format.xml { head :ok }
    end
  end
end
