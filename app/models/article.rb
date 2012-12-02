# Article extends Post model, adding author, site name, and guid fields. Used to store external sourced posts.


class Article < Post
  field :author, :type => String
  field :site_name, :type => String
  field :guid, :type => String

  validates :site_name, :presence => true
  validates :guid, :presence => true

  ##
  # Deliver weekly digest
  # Usage: In Rails Console, Article.deliver_weekly_digest
  ##
  def self.deliver_weekly_digest
    User.where(:digest_frequency => "Weekly").each do | u |
      UserMailer.deliver_weekly_email(u)
    end
  end

  ##
  # Get articles from predefined RSS feeds.
  # Usage: In Rails Console, Article.get_feeds
  ##
  def self.get_feeds
    feed_urls = %w(http://blog.8thlight.com/feed/atom.xml http://blog.gdinwiddie.com/feed/)
    update_from_feeds(feed_urls)
  end

  ##
  # Get articles for defined RSS feeds.
  # Usage: In Rails Console, Article.update_from_feeds("http://blog.8thlight.com/feed/atom.xml")
  ##
  def self.update_from_feeds(feed_urls)
    @user = User.find(:first, :conditions => { :slug => ENV['ARTICLE_USER_ID'] })
    @articles = {}
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    feeds.each do |feed_url, feed|
      add_entries(feed.entries, feed.title)
    end

    if !@articles.empty?
      UserMailer.deliver_article_email(@user, @articles)
    end
  end

  ##
  # Continuously get articles for defined RSS feeds.
  # Usage: In Rails Console, Article.update_from_feeds("http://blog.8thlight.com/feed/atom.xml", 300)
  ##
  def self.update_from_feeds_continuously(feed_urls, delay_interval = 300.seconds)
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)
    add_entries(feeds.entries, feed.title)
    loop do
      sleep delay_interval
      feeds = Feedzirra::Feed.update(feeds.entries)
      add_entries(feeds.new_entries, feed.title) if feeds.updated?
    end
  end

  private

  def self.add_entries(entries, title)
    entries.each do |entry|
      if self.unscoped.where(guid: entry.id).empty?
        art = create!(
            :title          => entry.title,
            :source_url     => entry.url,
            :created_at     => entry.published,
            :guid           => entry.id,
            :author         => entry.author,
            :content        => entry.content.blank? ? entry.title : entry.content,
            :site_name      => title,
            :user_id        => @user.id
        )
        @articles[art.source_url] = art.title + "##"  + art.content.truncate(350) + "##" + art.slug
      end
    end
  end
end