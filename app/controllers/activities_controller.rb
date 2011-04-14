class ActivitiesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @user = current_user
    @plan = @user.plan
    @activity = @plan.activities.build(params[:activity])

    if @activity.save
      redirect_to(@user, :notice => "Activity successfully created.")
    else
      redirect_to(@user, :flash => { :alert => "Activity could not be saved." })
    end
  end
end