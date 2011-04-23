class Tag
  include Mongoid::Document

  field :name, :type => String
  key :name
  
  references_many :posts

  validates :name, :presence => true, :uniqueness => true
end
