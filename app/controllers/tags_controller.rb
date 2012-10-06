class TagsController < ApplicationController
  def show

    @tag = Tag.first(:conditions => {:name => params[:id]})
    #@tag = Tag.find(params[:id])
  end
end