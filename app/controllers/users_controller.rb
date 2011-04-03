class UsersController < ApplicationController
  def show
    @user = current_user
    # @user = User.find(params[:id])
  end
end