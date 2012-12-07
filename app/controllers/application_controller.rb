# ApplicationController is the parent class of all the other controllers.

class ApplicationController < ActionController::Base
  protect_from_forgery

  # Load all helpers from app/helpers for use in all controllers and views
  helper :all

  # Retrieve the referrer's user name from the params hash of any request.
  before_filter do
    cookies['app-referrer-username'] = params[:r] if params[:r]
  end

  # Retrieve the most recent articles.
  def recent_posts
    @recent_posts ||= Post.desc(:created_at).limit(5)
  end

  # Retrieve all existing tags.
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
  # Get the text helpers (i.e pluralize, ... ) to use in the controller.
  def controller_text_helper
    ControllerTextHelper.instance
  end

  ##
  # Singleton instance of view text helpers (i.e pluralize, ... ) to be used by all controllers.
  class ControllerTextHelper
    include Singleton
    include ActionView::Helpers::TextHelper
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

  # Retrieve the path of the page that the user was on before he clicked the sign in link.
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end

  helper_method :recent_posts, :all_tags, :post_type
end
