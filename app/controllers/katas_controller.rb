class KatasController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]
  def new
    @kata = Kata.new
  end

  def create
    @kata = Kata.new(params[:kata])
    
    if @kata.save
      redirect_to(root_path, :notice => "Kata successfully created.")
    else
      redirect_to(root_path, :flash => { :alert => "Kata could not be saved." })
    end
  end
  
  def show
    @kata = Kata.find(params[:id])
  end
end