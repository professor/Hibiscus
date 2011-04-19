class PlansController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = current_user

    if @user.plan
      redirect_to(@user, :flash => { :alert => "You already have a learning plan." })
    else
      @plan = @user.build_plan(params[:plan])

      if @plan.save
        redirect_to(@user, :notice => "Thank you for creating your learning plan.")
      else
        redirect_to(@user, :flash => { :alert => "Your learning plan could not be saved." })
      end
    end
  end

  def edit
    @user = current_user
    @plan = @user.plan
  end

  def update
    @user = current_user
    @plan = @user.plan

    if @plan.update_attributes(params[:plan])
      redirect_to(@user, :notice => "Thank you for updating your learning plan.")
    else
      render :action => "edit"
    end
  end
end