Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :github, 'dbfcf188a1d4773e99ec', '6623613618f6e7de16396c21eadc65e8441dd975'
  #provider :developer
end