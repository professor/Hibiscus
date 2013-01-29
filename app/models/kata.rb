require 'indextank'
require "searchify"

# Kata represents the exercises to improve the software craftsmanship.
# The word 'kata' and 'exercise' refers to the same thing and they are interchangeable.
# Kata used to be an inherited class of Post. But now they are separate models as it's preferred
# to store them in different collections.
# Kata operations are managed by PostController because they share many operations and information in common.

class Kata
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  #paranoia module allows to implement "soft deletion"
  include Mongoid::Paranoia
  include Mongoid::Slug
  include Searchify

  #belongs_to :category
  has_and_belongs_to_many :categories

  attr_reader :category_tokens

  # Setter method for the categories that a Kata instance has and belongs to.
  def category_tokens=(ids)
    self.category_ids = ids.split(",")
  end

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
  # a kata must have one or more categories
  validates :category_ids, :presence => true

  VALID_WEBSITE_REGEX = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,6}(:[0-9]{1,5})?(\/.*)?$/ix
  validates :source_url, format: { with: VALID_WEBSITE_REGEX, :message => "Please enter a URL link, start with http"}, :allow_blank => true

  after_save :update_search_index
  after_save :update_fk_in_category
  before_destroy :delete_from_search_index

  max_versions 5

  ##
  # This method is to retrieve all reviews that are not deleted.
  # Thanks to Mongoid's extra Paranoia, deletion becomes soft delete so all deleted reviews are
  # still in database. However, Mongoid 2 is only able to retrieve all items (normal and deleted) if
  # items are in a sub-collection (reviews) under one collection (katas).
  # To retrieve only the normal items (non-deleted), this method is used. If update to Mongoid 3, this
  # method might not be necessary.
  def survived_reviews
    reviews.where(:deleted_at.exists => false)
  end

  #TODO: We are doing the update of the foreign keys manually because rails wasn't updating
  #if update to an newer version of mongoid, this might not be necessary
  def update_fk_in_category
    #check if there are categories for the kata
    return if !self.category_ids.is_a?(Array) || self.category_ids.empty?

    categ_list = Category.all()
    categ_list.each do |categ|
      if self.category_ids.include?(categ.id)
        categ.kata_ids.push(self.id) if !categ.kata_ids.include?(self.id)
      else
        categ.kata_ids.delete(self.id)
      end
      categ.save
    end
  end

  ##
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

  ##
  # get user-proposed categories for a kata
  def kata_user_categories
      kataUserCategories = []
      survived_reviews.each do |review|
        review.category_ids.each {|category_id| kataUserCategories << category_id}
      end
      kataUserCategories.uniq
  end
end