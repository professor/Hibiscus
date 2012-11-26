#CategoriesController handles the generation of the list of categories.

class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    #@categories = Category.all
    @categories = Category.find(:all, :conditions => {:name => Regexp.new(params[:q], true) })
    respond_to do |format|
      format.html
      format.json do
        render :json => @categories.map { |category| {:id => category._id, :name => category.name} }
      end
    end
  end

  def show
    @category = Category.find_by_slug(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
