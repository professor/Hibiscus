class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => :unsubscribe

  def show
    @user = User.find_by_slug(params[:id])
    @plan = @user.plan ? @user.plan : Plan.new
  end

  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])

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

  def unsubscribe
    User.find(params[:id]).update_attributes(:digest_frequency => '')

    respond_to do |format|
      format.html { redirect_to(root_url, :notice => "You have been unsubscribed.") }
      format.xml { head :ok }
    end
  end
end