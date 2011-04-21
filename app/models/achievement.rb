class Achievement
  include Mongoid::Document
  include Mongoid::Timestamps

  key :name

  field :name, :type => String
  field :level, :type => String
  field :description, :type => String

  validates :name, :presence => true
  validates :level, :presence => true
  validates :description, :presence => true

end
