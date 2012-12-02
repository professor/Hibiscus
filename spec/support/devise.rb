## module for helping request specs
module RequestMacros
  include Warden::Test::Helpers

  # Login for use in request specs
  def sign_in_as_a_user
    @user ||= FactoryGirl.create :user
    login_as @user
  end

  # Login for use in request specs
  def sign_in_as_an_admin
    @admin ||= FactoryGirl.create :admin
    login_as @admin
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include RequestMacros, :type => :request
end