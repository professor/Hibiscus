class TagsController < ApplicationController  
  def show

    @tag = Tag.where(:conditions => {:name => params[:id]}).first
#    @tag = Tag.find(params[:id])
  end
end