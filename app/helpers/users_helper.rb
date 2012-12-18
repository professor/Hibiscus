# This includes methods used in the User views

module UsersHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 40})
    if user.gravatar_email.nil?
      gemail = ''
    else
      gemail = user.gravatar_email.downcase
    end
    gravatar_id = Digest::MD5::hexdigest(gemail)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  # Returns true if the user with the provided ID has been blocked, or  false otherwise.
  def user_blocked(user_id)
    User.deleted.where(_id: user_id).any?
  end
end