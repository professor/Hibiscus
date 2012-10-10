class Category
  include Mongoid::Document

  field :name, :type => String
  key :name

  has_many :posts

  validates :name, :presence => true, :uniqueness => true
end
