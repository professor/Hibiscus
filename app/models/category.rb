#The Category model represents the intent of a Kata (what a kata is good for).
#Category is only related to Kata model. Kata model and Category have a many-to-many relationship

class Category
  include Mongoid::Document
  include Mongoid::Slug

  field :name, :type => String
  slug :name

  has_and_belongs_to_many :katas

  validates :name, :presence => true, :uniqueness => true

  scope :order_importance, order_by(:order => :asc)
end
