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

  ##
  # Get the view helpers to use in the controller.
  def help_controller
    OptionalViewHelper.instance
  end


=begin
  # allows redirecting for AJAX calls as well as normal calls
  def redirect_to(options = {}, response_status = {})
    if request.xhr?
      render(:update) {|page| page.redirect_to(options)}
    else
      super(options, response_status)
    end
  end
=end

  ##
  # Singleton instance of view helpers to be used by all controllers.
  class OptionalViewHelper
    include Singleton
    include ActionView::Helpers::TextHelper
  end

  helper_method :recent_posts, :all_tags, :post_type
end
