## module for helping feature specs
module FeatureMacros
  include Warden::Test::Helpers

  # Login for use in feature specs
  def sign_in_as_a_user
    @user ||= FactoryGirl.create :user
    login_as @user
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, :type => :controller
  config.include FeatureMacros, :type => :feature
end