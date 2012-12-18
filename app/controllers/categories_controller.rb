#CategoriesController handles the operations related with Category

class CategoriesController < ApplicationController
  before_filter :authenticate_user!, :only => [:index]

  #Returns the list of categories in a json object (to be used by tokenized input)
  def index
    @categories = Category.find(:all, :conditions => {:name => Regexp.new(params[:q], true) })
    respond_to do |format|
      format.html
      format.json do
        render :json => @categories.map { |category| {:id => category._id, :name => category.name} }
      end
    end
  end

  #Shows the list of katas associated to a Category
  def show
    @category = Category.find_by_slug(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
  end

end
