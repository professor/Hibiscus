class Activity
  include Mongoid::Document

  field :name, :type => String

  embedded_in :plan #, :opposite => :activities

  validates :name, :presence => true
end