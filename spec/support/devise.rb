## module for helping request specs
module RequestMacros
  include Warden::Test::Helpers

  # Login for use in request specs
  def sign_in_as_a_user
    @user ||= FactoryGirl.create :user
    login_as @user
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include RequestMacros, :type => :request
end