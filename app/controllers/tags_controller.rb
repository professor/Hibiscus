class TagsController < ApplicationController
  def show

    @tag = Tag.find_by_slug(:conditions => {:name => params[:id]})
    #@tag = Tag.find(params[:id])
  end
end