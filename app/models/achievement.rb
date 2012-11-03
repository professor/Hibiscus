class Achievement
  include Mongoid::Document
  include Mongoid::Timestamps
 # include Mongoid::Slug

  key :name
#  slug :name

  field :name, :type => String
  field :level, :type => String
  field :description, :type => String

  validates :name, :presence => true, :uniqueness => true
  validates :level, :presence => true
  validates :description, :presence => true

end
