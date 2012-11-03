class CategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @categories = Category.all
    #@categories = Category.where(:name => "#{params[:q]}")
    #@categories = Category.where(:name => "/.*others.*/" )
    #@categories = Category..any_of({ :name => /o/ })
    #where("name like ?", "%#{params[:q]}%")
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
