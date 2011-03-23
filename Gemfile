source "http://rubygems.org"

gem "rails", "3.0.5"

group :development do
	gem "rdoc"
end

group :test do
	gem "cover_me"
	gem "factory_girl_rails"
	gem "database_cleaner"
	gem "mongoid-rspec"

	# Next gems are not required in the application, but are needed for testing. These should be in the "global" gemset of RVM.
  # gem "autotest"
  # gem "autotest-rails"
	# gem "autotest-growl"
	# gem "autotest-fsevent"
end

group :production do
	# Production gems here.
end

group :development, :test do
	gem "rspec-rails"
end

group :development, :production do
	# Development and production gems here.
end

group :test, :production do
	# Test and production gems here.
end

group :development, :test, :production do
	gem "mongoid", ">= 2.0.0.rc.7"
	gem "bson_ext"
	gem "devise"
	gem 'omniauth'
	gem 'oa-openid', :require => 'omniauth/openid'
	# OpenID has some problems with long URLs in WEBrick.
	gem 'mongrel', '1.2.0.pre2'
end