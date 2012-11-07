require 'indextank'
require "searchify"

# Kata is a model inherited from Post model.
#
# The reason to do inheritance is because Kata shares most of fields
# with Post and also has some extra fields.

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
  field :source, :type => String
  field :rating, :type => Float, default: 0.0

  field :challenge_level, :type => String
  field :user_categories, :type => String

  slug :title

  embeds_many :reviews
  #both teams decide to remove it
  #references_many :likes, :dependent => :destroy
  has_and_belongs_to_many :tags
  referenced_in :user

  validates :title, :presence => true
  validates :content, :presence => true
  validates :user_id, :presence => true
  # challenge_level can be "low", "medium", "high"
  validates :challenge_level, presence: true, inclusion: { in: %w(Low Medium High) }
  # a kata must have one and only one category
  validates :category, presence: true

  after_save :update_search_index
  before_destroy :delete_from_search_index

  def survived_reviews
    reviews.delete_if { |review| !review[:deleted_at].nil? }
  end
end