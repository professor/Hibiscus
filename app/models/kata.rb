require 'indextank'
require "searchify"

# Kata represents the exercises to improve the software craftsmanship.
# Kata operations are managed by PostController because they share many operations and information in common.

class Kata
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  #paranoia module allows to implement "soft deletion"
  include Mongoid::Paranoia
  include Mongoid::Slug
  include Searchify

  belongs_to :category

  attr_accessor :tempTags

  field :title, :type => String
  field :content, :type => String
  field :source, :type => String #Remove in next release
  field :source_url, :type => String
  field :rating, :type => Float, default: 0.0

  field :challenge_level, :type => String
  field :user_categories, :type => String

  slug :title

  embeds_many :reviews
  references_many :flags, :dependent => :destroy
  has_and_belongs_to_many :tags
  referenced_in :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  # challenge_level can be "low", "medium", "high"
  validates :challenge_level, presence: true, inclusion: { in: %w(Low Medium High) }
  # a kata must have one and only one category
  validates :category, presence: true
  VALID_WEBSITE_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  validates :source_url, format: { with: VALID_WEBSITE_REGEX, :message => "Please enter a URL link, start with http"}, :allow_blank => true

  after_save :update_search_index
  before_destroy :delete_from_search_index

  def survived_reviews
    reviews.where(:deleted_at.exists => false)
  end

  # return challenge level as a number: 1 for low, 2 for medium and 3 for high
  def digital_challenge_level
    case self.challenge_level
      when 'Low'
        1
      when 'Medium'
        2
      when 'High'
        3
    end
  end

end