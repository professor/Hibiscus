class ApplicationController < ActionController::Base
  protect_from_forgery

  def recent_posts
    @recent_posts ||= Post.desc(:created_at).limit(5)
  end

  def all_tags
    @all_tags ||= Tag.all
  end

  ##
  # Get the type of a post using the type in the params hash passed to
  # controller action. If the type param is not present, return Post.
  def post_type
    @type = params[:type].blank? ? "Post" : params[:type]
    @type.constantize
  end

  def help
    Helper.instance
  end

  class Helper
    include Singleton
    include ActionView::Helpers::TextHelper
  end

  helper_method :recent_posts, :all_tags, :post_type
end
