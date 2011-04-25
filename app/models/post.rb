require 'indextank'

class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  
  attr_accessor :tempTags
  
  field :title, :type => String
  field :content, :type => String
  
  key :title

  embeds_many :comments
  references_many :likes, :dependent => :destroy
  has_and_belongs_to_many :tags
  referenced_in :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  
  def listLikes
    likes = []
    self.likes.each do |l|
      likes << l unless l.isDislike
    end
    
    return likes
  end
  
  def listDislikes
    dislikes = []
    self.likes.each do |l|
      dislikes << l if l.isDislike
    end
    
    return dislikes
  end

  def update_search_index(url)
    a = ENV['INDEXTANK_API_URL']
    api = IndexTank::Client.new(ENV['INDEXTANK_API_URL'] || '<API_URL>')
    index = api.indexes 'idx'
    index.document(url).add({ :title => self.title, :timestamp => self.created_at.to_i, :text => self.content.gsub(/<\/?[^>]*>/, ""), :url => url, :id => self.id})
  end
  
  def isKata?
    self.tags.each do |tag|
      return true if tag.name == "kata"
    end
    
    return false
  end

end
