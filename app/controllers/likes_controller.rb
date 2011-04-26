class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @post = Post.find(params[:like][:post_id])
    @like = Like.new(params[:like])
    @like.user = current_user

    if @like.save
      redirect_to(@post, :notice => params[:like][:is_dislike] ? 'You disliked this post.' : 'You liked this post.')
    else
      redirect_to(@post, :flash => { :alert => 'Your like could not be recorded.' })
    end
  end
end