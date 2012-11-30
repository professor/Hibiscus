# Category is only related to Kata model, representing the category a kata belongs to.

class Category
  include Mongoid::Document
  include Mongoid::Slug

  field :name, :type => String
  slug :name

  has_and_belongs_to_many :katas

  validates :name, :presence => true, :uniqueness => true

  scope :order_importance, order_by(:order => :asc)
end
