class Tag
  include Mongoid::Document
  include Mongoid::Slug

  field :name, :type => String
  slug :name
  
  has_and_belongs_to_many :posts

  validates :name, :presence => true, :uniqueness => true
end
