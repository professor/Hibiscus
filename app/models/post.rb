require 'indextank'
require "searchify"

##
# Post is the model for posted articles (Post), and the base model for article feeds(Article).
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  #paranoia module allows to implement "soft deletion"
  include Mongoid::Paranoia
  include Mongoid::Slug
  include Searchify
  include ActsAsVoteable
  
  attr_accessor :tempTags

  acts_as_voteable
  
  field :title, :type => String
  field :content, :type => String

  #Adding new field source

  field :source_url, :type => String
  field :rating, :type => Float
  field :vote_score, :type => Integer, default: 0

  slug :title

  embeds_many :comments
  references_many :likes, :dependent => :destroy
  references_many :flags, :dependent => :destroy
  has_and_belongs_to_many :tags
  referenced_in :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true

  after_save :update_search_index
  before_destroy :delete_from_search_index

  max_versions 5

  ##
  # Get user likes array for a post
  def listLikes
    likes = []
    self.likes.each do |l|
      likes << l unless l.is_dislike
    end
    
    return likes
  end

  ##
  # Get user dislikes array for a post
  def listDislikes
    dislikes = []
    self.likes.each do |l|
      dislikes << l if l.is_dislike
    end
    
    return dislikes
  end

  ##
  # Get tags name array for a post
  def joinTags
    tags = []
    self.tags.each do |tag|
      tags << tag.name
    end
    
    return tags.join(", ")
  end

  ##
  # Set post tags from a tag name string. The post tags are included in an array of Tag objects.
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

  ##
  # Get all comments that are not deleted for a post
  def survived_comments
    comments.where(:deleted_at.exists => false)
  end

  ##
  # Update the vote score for a post
  def update_vote_score
    self.vote_score = self.plusminus
    save
  end
end
