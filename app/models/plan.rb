class Plan
  include Mongoid::Document

  field :maidenSpeech, :type => String

  embedded_in :user, :opposite => :plan
  embeds_many :activities

  validates :user, :presence => true
end