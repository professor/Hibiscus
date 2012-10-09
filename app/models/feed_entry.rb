class FeedEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :guid, :type => String
  field :name, :type => String
  field :published_at, :type => String
  field :summary, :type => String
  field :url, :type => String

  def self.get_feeds
    feed_urls = %w(http://www.thoughtworks.com/blogs/rss/current http://blog.8thlight.com/feed/atom.xml)
    update_from_feeds(feed_urls)
  end

  def self.update_from_feeds(feed_urls)
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    feeds.each do |feed_url, feed|
      add_entries(feed.entries)
    end
  end

  def self.update_from_feeds_continuously(feed_urls, delay_interval = 300.seconds)
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    add_entries(feeds.entries)
    loop do
      sleep delay_interval
      feeds = Feedzirra::Feed.update(feeds.entries)
      add_entries(feeds.new_entries) if feeds.updated?
    end
  end

  private

  def self.add_entries(entries)
    # == Summary
    # Parser for dealing with RDF feed entries.
    #
    # == Attributes
    # * title
    # * url
    # * author
    # * content
    # * summary
    # * published
    # * categories
    entries.each do |entry|
      unless exists?(:conditions => {:guid => entry.id})
        create!(
            :name         => entry.title,
            :summary      => entry.summary,
            :url          => entry.url,
            :published_at => entry.published,
            :guid         => entry.id
        )
      end
    end
  end

end