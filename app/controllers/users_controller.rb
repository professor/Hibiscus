class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => :unsubscribe

  def index
    @users = User.all.asc(:display_name)
    @blocked_users = User.deleted.asc(:display_name)
    authorize! :edit, @users.first
  end

  def show
    @user = User.find_by_slug(params[:id])
    @plan = @user.plan ? @user.plan : Plan.new
    @katas = @user.katas
    @posts = @user.posts
    @articles = @posts.where(_type: "Article")
    @comments = @user.comments
    @reviews = @user.reviews
  end

  def edit
    @user = User.find_by_slug(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find_by_slug(params[:id])
    authorize! :update, @user

    @user.email = params[:user][:email]
    @user.gravatar_email = params[:user][:gravatar_email]
    @user.digest_frequency = params[:user][:digest_frequency]

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => "Profile was successfully updated.") }
        format.xml { head :ok }
        format.js
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @user = User.find_by_slug(params[:id])
    authorize! :destroy, @user

    if @user.delete
      redirect_to(User, :notice => "The user has been blocked.")
    else
      redirect_to(User, :alert => "The user: #{@user.username} has not been blocked.")
    end
  end

  def restore
    @user = User.deleted.where(:slug => params[:id]).first
    authorize! :destroy, @user

    if @user.restore
      redirect_to(User, :notice => "The user has been unblocked.")
    else
      redirect_to(User, :alert => "The user: #{@user.username} has not been unblocked.")
    end
  end

  def obliterate
    @user = User.deleted.where(:slug => params[:id]).first
    authorize! :destroy, @user

    if @user.destroy!
      redirect_to(User, :notice => "The user has been deleted permanently.")
    else
      redirect_to(User, :alert => "The user: #{@user.username} has not been deleted permanently.")
    end
  end

  def unsubscribe
    @user = User.where(:slug => params[:id]).first

    if @user.nil?
      flash[:alert] = "Unsubscribe Process Unsuccessful. User does not exist."
    else
      @user.update_attributes(:digest_frequency => '')
      flash[:notice] = "You have been unsubscribed."
    end
    redirect_to(root_url)
  end
end