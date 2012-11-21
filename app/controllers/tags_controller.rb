class TagsController < ApplicationController
  def show

    @tag = Tag.find_by_slug(params[:id])
    #@tag = Tag.find(params[:id])
  end
end