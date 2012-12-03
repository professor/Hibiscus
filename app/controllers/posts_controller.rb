# PostsController handles model and view for Post, Article, and Kata. When <tt>param[:type]</tt>
# is specified, it serves the specified models (Kata, Article) using the same methods as for Post.
# In code, post_type is used as a generic representative of Post, Article and Kata.
# There are two reasons why Post, Article and Kata are sharing the same controller.
# 1. Article is a extended model of Post. It's reasonable for parent and child models to use the same
#    controller. Kata used to be an inherited model of Post, too. But now Kata uses a different model
#    because it's preferred to keep Post (including Article) and Kata in different collection.
# 2. Post, Article and Kata basically are all writings for readers. They share a lot of common
#    operations such as show, new, edit, create, update, destroy. We use the same controller to stay DRY.

class PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show, :random]
  before_filter :post_type

  ##
  # Retrieve all Posts, Article or Katas and displays them
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

  ##
  # Show a single post/article/kata. In order to keep the url clean and readable, the title of
  # post/article/kata is used as its ID. A problem is that id, once created, cannot be changed
  # in mongoid. To make the title still editable, a gem 'mongoid-slug' is used and find_by_slug
  # method is used instead of find.
  # More about this gem: https://github.com/digitalplaywright/mongoid-slug
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

  ##
  # Randomly pick one item whose type is specified by post_type.
  # Currently only used by Kata.
  def random
    @posts = post_type.all
    @post = @posts.at(rand(@posts.count))
    respond_to do |format|
      format.html { redirect_to(@post, :notice => "Enjoy the challenge!") }
    end
  end


  ##
  # Instantiate a new post/article/kata.
  def new
    @post = post_type.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @post }
    end
  end

  ##
  # Retrieve a post/kata to edit with its tags and categories if any.
  def edit
    @post = post_type.find_by_slug(params[:id])
    authorize! :update, @post
    if post_type != Kata
      @tags = @post.joinTags
    end
  end

  ##
  # Create a post/article/kata. The user will be rewarded for 10 points for the creation.
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
  # Update the attributes of a post/article/kata, and generate a notice if the changes could
  # be saved or retry to edit otherwise.
  # The attributes to be saved are different between Post and Kata.
  # For Post, tags and source url need to be saved.
  # For Kata, categories, challenge level and source url need to be saved.
  def update
    @post = post_type.find_by_slug(params[:id])
    authorize! :update, @post
    @form = params[@type.downcase.to_sym]
    if post_type == Post
      @post.tempTags = @form[:tempTags]
      @post.setTags
      @post.source_url = params[@type.downcase.to_sym][:source_url]
    elsif post_type == Kata
      @post.category_ids = @form[:category_tokens].to_s.split(",")
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

  ##
  # Delete a post/article/kata. Thanks to Mongoid extra 'Paranoia', the delete is soft delete and
  # can be restored.
  # More about Paranoia in Mongoid: http://mongoid.org/en/mongoid/docs/extras.html#paranoia
  def destroy
    @post = post_type.find_by_slug(params[:id])
    authorize! :destroy, @post
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(post_type, :notice => "The #{@type} has been deleted.") }
      format.xml { head :ok }
    end
  end

  ##
  # Vote up for a post/article/kata. It will add one vote to the voteable object and update its vote
  # score. The voter gets 1 point as reward.
  # Currently used on Post/Article but not Kata.
  def upvote
    @post = post_type.find_by_slug(params[:id])
    current_user.vote_for(@post)
    current_user.add_points(1)
    @post.update_vote_score
    respond_to do |format|
      format.js
    end
  end

  ##
  # Vote down for a post/article/kata. It will reduce one vote to the voteable object and update its vote
  # score. The voter gets 1 point as reward.
  # Currently only used on Post/Article but not Kata.
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
