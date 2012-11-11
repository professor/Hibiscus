#require 'rubygems'
#require 'rake'
#require 'fileutils'

desc "This task is called by the Heroku scheduler add-on"
namespace :hibiscus do
  desc "Get articles from rss"
  task(:get_articles_from_rss => :environment) do
    puts "get_articles_from_rss started..."
    Article.get_feeds
    puts "get_articles_from_rss finished."
  end

  desc "hello world"
  task(:hello_world => :environment) do
    puts "hello world"
  end
end

