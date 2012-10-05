Rails.application.config.middleware.use OmniAuth::Builder do

  ENV['GITHUB_ID'] =  "71cc9a326ce3246ca8bf"
  ENV['GITHUB_SECRET'] = "3998fcf2ad365f11bc9a0d39a882b0860cf805b7"
  provider :github, ENV['GITHUB_ID'], ENV['GITHUB_SECRET']
  #provider :github, '71cc9a326ce3246ca8bf', '3998fcf2ad365f11bc9a0d39a882b0860cf805b7'
end