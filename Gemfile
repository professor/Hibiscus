require "rubygems"
require "mongo"
source "http://gemcutter.org"
source "http://rubygems.org"

gem "rails", "3.0.5"

group :development do
	gem "rdoc"
end

group :test do
	gem "cover_me"
	gem "factory_girl_rails"

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
	gem "mongo_mapper"
end