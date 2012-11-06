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
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
