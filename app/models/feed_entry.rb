class FeedEntry
  include Mongoid::Document
  include Mongoid::Timestamps

  field :guid, :type => String
  field :name, :type => String
  field :published_at, :type => String
  field :summary, :type => String
  field :url, :type => String
  field :author, :type => String
  field :blog_name, :type => String

  validates :guid, :presence => true
  validates :name, :presence => true

  def self.get_feeds
    feed_urls = %w(http://cleancoder.posterous.com/rss.xml http://blog.8thlight.com/feed/atom.xml http://blog.gdinwiddie.com/feed/ http://blog.coachcamp.org/feed/ http://craftedsw.blogspot.com/feeds/posts/default)
    update_from_feeds(feed_urls)
  end

  def self.update_from_feeds(feed_urls)
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    feeds.each do |feed_url, feed|
      add_entries(feed.entries, feed.title)
    end
  end

  def self.update_from_feeds_continuously(feed_urls, delay_interval = 300.seconds)
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    add_entries(feeds.entries, feed.title)
    loop do
      sleep delay_interval
      feeds = Feedzirra::Feed.update(feeds.entries)
      add_entries(feeds.new_entries) if feeds.updated?
    end
  end

  private

  def self.add_entries(entries, title)
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
            :guid         => entry.id,
            :author       => entry.author,
            :blog_name    => title
        )
      end
    end
  end

end