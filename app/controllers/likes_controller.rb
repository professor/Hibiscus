class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @post = Post.find(params[:like][:post_id])
    @like = Like.new(params[:like])
    @like.user = current_user

    respond_to do |format|
      if @like.save
        current_user.add_points(1)
        format.html { redirect_to(@post, :notice => params[:like][:is_dislike] ? 'You disliked this post.' : 'You liked this post.') }
        format.js
      else
        format.html { redirect_to(@post, :flash => { :alert => 'Your like could not be recorded.' }) }
        format.js
      end
    end
  end
end