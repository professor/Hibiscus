#require 'rubygems'
#require 'rake'
#require 'fileutils'

desc "This task is called by the Heroku scheduler add-on"
namespace :hibiscus do
  desc "Get articles from rss"
  task(:get_articles_from_rss => :environment) do
    Article.get_feeds
  end

  desc "hello world"
  task(:hello_world => :environment) do
    puts "hello world"
  end
end

