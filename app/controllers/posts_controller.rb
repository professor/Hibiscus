# PostsController handles model and view for Post. When <tt>param[:type]</tt>
# is specified, it is also capable to handle Post's inherited models
# (Kata, Feed) using the same methods.

class PostsController < ApplicationController
  before_filter :authenticate_user!,  :except => [:index, :show]
  before_filter :post_type

  ##
  # Retrieve all posts of the specified type.
  def index
    @posts = (@type == 'Post') ? post_type.where(_type: nil) : post_type.where(_type: @type)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = post_type.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @likes = @post.listLikes
    @dislikes = @post.listDislikes

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end


  ##
  # Instantiate a new post, and retrieve all the categories that it might belong to if it is of type 'Kata'
  def new
    @post = post_type.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  ##
  # Retrieve a post to edit with its tags and categories if any.
  def edit
    @post = post_type.find(params[:id])
    @tags = @post.joinTags
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = post_type.new(params[@type.downcase.to_sym])
    @post.user = current_user
    @post.setTags

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => "#{@type} was successfully created.") }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  ##
  # Update the attributes of a post, and generate a notice if the changes could
  # be saved or retry to edit otherwise.
  def update
    @post = post_type.find(params[:id])
    @form = params[@type.downcase.to_sym]
    if post_type == Post
      @post.tempTags = @form[:tempTags]
      @post.setTags
    else
      @post.category = @form[:category]
      @post.challenge_level = @form[:challenge_level]
    end
    @post.title = @form[:title]
    @post.content = params[@type.downcase.to_sym][:content]
    @post.source = params[@type.downcase.to_sym][:source]

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => "#{@type} was successfully updated.") }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = post_type.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(post_type, :notice => "The #{@type} has been deleted.") }
      format.xml  { head :ok }
    end
  end
end
