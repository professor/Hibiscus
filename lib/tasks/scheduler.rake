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

  desc "Delivery weekly digeset"
  task(:deliver_weekly_digest => :environment) do
    if Date.today.wday == 2 # run on Tuesdays
      puts "deliver_weekly_digest started..."
      Article.deliver_weekly_digest
      puts "deliver_weekly_digest finished."
    end
  end

  desc "hello world"
  task(:hello_world => :environment) do
    puts "hello world"
  end
end

