class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find_by_slug(params[:id])
    @plan = @user.plan ? @user.plan : Plan.new
  end
end