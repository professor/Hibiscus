class AuthenticationsController < ApplicationController
  
  # Load user's authentications. Currently only Google thru OpenID, but potentially more in types of authentication in the future.
  def index
    @authentications = current_user.authentications if current_user
  end
  
  # Create an authentication when this is called from the authentication provider callback
  def create
    omniauth = request.env["omniauth.auth"]
    
    # Attempt to find the first entry in Authentication where the provider and the UID match. 
    authentication = Authentication.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
    
    # Secnario 1: User has connected before and has an account.
    if authentication
      flash[:notice] = "You have successfully signed in."
      sign_in(authentication.user)
      redirect_to authentications_url
      
    # Scenario 2: User has an account (must be logged in), but is using a new authentication mechanism provided by OmniAuth.
    # elsif current_user
    
    # Scenario 3: User is completely new to the system.
    elsif user = register_new_user(omniauth)
      user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Welcome to CraftWiki!"
      sign_in(user)
      redirect_to authentications_url
    else
      flash[:error] = "Error logging in."
      redirect_to authentications_url
    end
  end
  
  # Destroy an authentication
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "You have successfully removed the authentication."
    redirect_to authentications_url
  end
  
  def register_new_user(omniauth)
    user = User.new
    user.register_with_omniauth(omniauth)
    if user.save!
      user
    else
      nil
    end
  end
end
