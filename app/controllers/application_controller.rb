class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def recent_posts
    @recent_posts ||= Post.desc(:created_at).limit(5)
  end
  
  def all_tags
    @all_tags ||= Tag.all
  end

  def post_type
    @type = params[:type].blank? ? "Post" : params[:type]
    @type.constantize
  end
    
  helper_method :recent_posts, :all_tags, :post_type
end
