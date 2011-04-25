class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def recent_posts
    @recent_posts ||= Post.desc(:created_at).limit(5)
  end
  
  def all_tags
    @all_tags ||= Tag.all
  end
    
  helper_method :recent_posts, :all_tags
end
