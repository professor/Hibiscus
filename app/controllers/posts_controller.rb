
class PostsController < ApplicationController
  before_filter :authenticate_user!,  :except => [:index, :show]

  # GET /posts
  # GET /posts.xml
  def index
    @posts = post_type.where(_type: @type)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = post_type.find(params[:id])
    @commentable = @post
    @comments = @post.comments
    @comment = Comment.new
    @likes = @post.listLikes
    @dislikes = @post.listDislikes

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = post_type.new
    @categories = Category.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = post_type.find(params[:id])
    @tags = @post.joinTags
    @categories = Category.all
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

  # PUT /posts/1
  # PUT /posts/1.xml
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

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
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
      format.html { redirect_to(@post, :notice => 'The post has been deleted.') }
      format.xml  { head :ok }
    end
  end
end
