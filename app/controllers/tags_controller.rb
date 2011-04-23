class TagsController < ApplicationController
  def create
  end
  
  def show
    @tag = Tag.find(params[:id])
  end
end