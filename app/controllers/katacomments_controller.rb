class KatacommentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def create
    @post = Post.find(params[:post_id])
    @katacomment = @post.katacomments.build(params[:kataComment])
    @katacomment.user = current_user

    if @katacomment.save
      redirect_to(@post, :notice => 'Thank you for your Kata feedback.')
    else
      redirect_to(@post, :flash => { :alert => 'Your Kata feedback could not be saved.' })
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @katacomment = @post.katacomments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @katacomment = @post.katacomments.find(params[:id])
    if @katacomment.update_attributes(params[:kataComment])
      redirect_to(@post, :notice => 'Thank you for the update in your Kata feedback.')
    else
      render :action => "edit"
    end
  end
end