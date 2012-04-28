module IntegrationSpecHelper
  def login_with_oauth(service = :github)
    visit "/auth/#{service}"
  end
end