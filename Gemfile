source "http://rubygems.org"

gem "rails", "3.0.19"

group :development do
	gem "rdoc"
	#gem "ruby-debug-ide"
	#gem "ruby-debug-base19x"
end

group :test do
	gem "cover_me"
	gem "factory_girl_rails"
	gem "database_cleaner"
	gem "mongoid-rspec"
	gem "metrical"

	# Next gems are not required in the application, but are needed for testing. These should be in the "global" gemset of RVM.
  # gem "autotest"
  # gem "autotest-rails"
	# gem "autotest-growl"
	# gem "autotest-fsevent"
end

group :production do
#  gem 'exception_notification', :require => 'exception_notifier'
  gem 'exception_notification', :git => 'git://github.com/alanjds/exception_notification.git'
end

group :development, :test do
	gem "rspec-rails"
	gem "capybara", "1.1.3"
	gem "launchy"
end

group :development, :production do
	# Development and production gems here.
end

group :test, :production do
	# Test and production gems here.
end

# Modified by Norman Xin on Oct. 4, 2012
group :development, :test, :production do
	gem "mongoid", ">= 2.2.6" #the latest to support rails 3.0.x
  gem "mongoid_slug", "~> 0.10.0"
	gem "bson_ext"
	gem "devise", "1.1.8"
	gem 'omniauth','1.0'
  gem 'omniauth-github'
  gem "indextank"
	gem "faraday-stack" #,  '= 0.1.5' #it appears that indextank needs this?
  gem "ckeditor", "3.6.3"
  gem 'mongoid-paperclip', :require => 'mongoid_paperclip'
  gem "jquery-rails"
#  gem 'json_pure', '1.4.6', :require => 'json'
  gem "feedzirra"
  gem "gamify"
  gem "cancan"
end

