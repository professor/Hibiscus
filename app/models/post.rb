require 'indextank'

# Post is the model for articles, and the base model for katas(Kata) and feeds(Feed).

class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  #paranoia module allows to implement "soft deletion"
  include Mongoid::Paranoia
  
  attr_accessor :tempTags
  
  field :title, :type => String
  field :content, :type => String

  #Adding new field source

  field :source, :type => String
  field :rating, :type => Float

  key :title

  embeds_many :comments
  references_many :likes, :dependent => :destroy
  has_and_belongs_to_many :tags
  referenced_in :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  after_save :update_search_index
  before_destroy :delete_from_search_index

  def listLikes
    likes = []
    self.likes.each do |l|
      likes << l unless l.is_dislike
    end
    
    return likes
  end
  
  def listDislikes
    dislikes = []
    self.likes.each do |l|
      dislikes << l if l.is_dislike
    end
    
    return dislikes
  end

  def update_search_index
    url = "posts/" + self.id
    api = IndexTank::Client.new(ENV['SEARCHIFY_HIBISCUS_API_URL'] || '<API_URL>')
    tmp = ENV['SEARCHIFY_HIBISCUS_INDEX']
    index = api.indexes(ENV['SEARCHIFY_HIBISCUS_INDEX'] || 'hibiscus')
    index.document(self.id.to_s).add({ :title => self.title, :timestamp => self.created_at.to_i, :text => self.content.gsub(/<\/?[^>]*>/, ""), :url => url, :id => self.id})
  end

  def delete_from_search_index
    url = "posts/" + self.id
    api = IndexTank::Client.new(ENV['SEARCHIFY_HIBISCUS_API_URL'] || '<API_URL>')
    index = api.indexes(ENV['SEARCHIFY_HIBISCUS_INDEX'] || 'hibiscus')
    index.document(url).delete
  end
  
  def joinTags
    tags = []
    self.tags.each do |tag|
      tags << tag.name
    end
    
    return tags.join(", ")
  end
  
  def setTags
    self.tags.nullify
    
    unless self.tempTags.blank?
      tempTags = self.tempTags.split(",")
    
      tempTags.each do |tag|
        self.tags << Tag.find_or_create_by(:name => tag.strip.downcase)
        # puts "TAGS: " + self.tags.to_s
      end
    end
  end
end
