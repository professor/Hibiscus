# PostsController handles model and view for Post, Article, and Kata. When <tt>param[:type]</tt>
# is specified, handle the specified models (Kata, Article) using the same methods as for Post.

class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :random]
  before_filter :post_type

  ##
  # Retrieve all Posts or Katas and displays them
  def index
    if params[:popular].blank?
      @posts = post_type.all
    else
      @posts = post_type.desc(:vote_score)
    end

    @categories = Category.order_importance

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @posts }
      format.rss { render :layout => false } #index.rss.builder
    end
  end



  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = post_type.find_by_slug(params[:id])

    if @post.blank?
      redirect_to(root_path(), :notice => "Sorry, we couldn't find what you were looking for " + params[:id]) and return
    end

    #TODO; refactor
    @commentable = @post
    if @post.is_a?(Kata)
      @comments = @post.survived_reviews.desc(:vote_score, :last_update)
      @comment = Review.new
    else
      @comments = @post.survived_comments.desc(:vote_score, :last_update)
      @comment = Comment.new
    end

    if post_type != Kata
      @likes = @post.listLikes
      @dislikes = @post.listDislikes
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @post }
    end
  end

  # GET /katas/1
  # GET /katas/1.xml
  def random
    @posts = post_type.all
    @post = @posts.at(rand(@posts.count))
    respond_to do |format|
      format.html { redirect_to(@post, :notice => "Enjoy the challenge!") }
    end
  end


  ##
  # Instantiate a new post, and retrieve all the categories that it might belong to if it is of type 'Kata'
  def new
    @post = post_type.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @post }
    end
  end

  ##
  # Retrieve a post to edit with its tags and categories if any.
  def edit
    @post = post_type.find_by_slug(params[:id])
    authorize! :update, @post
    if post_type != Kata
      @tags = @post.joinTags
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = post_type.new(params[@type.downcase.to_sym])
    @post.user = current_user
    if post_type != Kata
      @post.setTags
    end

    current_user.add_points(10)

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => "#{@type} was successfully created.") }
        format.xml { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Update the attributes of a post, and generate a notice if the changes could
  # be saved or retry to edit otherwise.
  def update
    @post = post_type.find_by_slug(params[:id])
    authorize! :update, @post
    @form = params[@type.downcase.to_sym]
    if post_type == Post
      @post.tempTags = @form[:tempTags]
      @post.setTags
      @post.source_url = params[@type.downcase.to_sym][:source_url]
    elsif post_type == Kata
      @post.category = @form[:category]
      @post.challenge_level = @form[:challenge_level]
      @post.source_url = params[@type.downcase.to_sym][:source_url]
    end
    @post.title = @form[:title]
    @post.content = params[@type.downcase.to_sym][:content]

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => "#{@type} was successfully updated.") }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = post_type.find_by_slug(params[:id])
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(post_type, :notice => "The #{@type} has been deleted.") }
      format.xml { head :ok }
    end
  end

  def upvote
    @post = post_type.find_by_slug(params[:id])
    current_user.vote_for(@post)
    current_user.add_points(1)
    @post.update_vote_score
    respond_to do |format|
      format.js
    end
  end

  def downvote
    @post = post_type.find_by_slug(params[:id])
    current_user.vote_against(@post)
    current_user.add_points(1)
    @post.update_vote_score
    respond_to do |format|
      format.js
    end
  end
end
