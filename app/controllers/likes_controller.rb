class LikesController < ApplicationController
  def create
    @post = Post.find(params[:like][:post_id])
    @like = Like.new(params[:like])
    @like.user = current_user
    
    if @like.save
      redirect_to(@post, :notice => 'You liked this post.')
    else
      redirect_to(@post, :flash => { :error => 'Your like could not be recorded.' })
    end
  end
end