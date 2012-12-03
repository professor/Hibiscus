# AuthenticationsController handles the creation, authentication, and listing of users.
# Creation and authentication of users is triggered by an omniauth callback, and user
# sessions are enforced using devise.

class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [:create]

  # Load user's authentications (Github).
  def index
    @authentications = current_user.authentications if current_user
  end

  # Create an authentication when this is called from the authentication provider callback
  def create
    omniauth = request.env["omniauth.auth"]
    #render :text => omniauth.to_json
    
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
    if authentication
      # If a user has already signed on with this authentication,
      # and he is not blocked, or obliterated, just sign the user in.
      blocked_user = User.deleted.where(_id: authentication.user_id).first
      if authentication.user
        flash[:notice] = "You are now signed in."
        sign_in_and_redirect(:user, authentication.user)
      elsif blocked_user
        flash[:alert] = "Your account has been blocked."
        redirect_to(root_url)
      else
        # User is obliterated
        flash[:alert] = "You are not allowed to sign in."
        redirect_to(root_url)
      end
    else
      # User is new, create an authentication and a user.
      user = User.create(:username => omniauth['info']['nickname'], :email => omniauth['info']['email'],
                         :name => omniauth['info']['name'], :digest_frequency => "Weekly",
                         :referrer_username => cookies['app-referrer-username'])
      auth = user.authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
    
      if auth.save
        flash[:notice] = "Welcome to CraftWiki!"
        sign_in_and_redirect(:user, user)
      else
        flash[:alert] = "Something went wrong during account creation: " + user.errors.full_messages.to_s
        redirect_to(root_url)
      end
    end
  end
end