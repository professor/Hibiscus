class Plan
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning

  field :maidenSpeech, :type => String, :default => "For me Software Craftsmanship includes the notion of 'X'. I want to
get better at 'X'. What does the community think will help me improve in this area? "

  embedded_in :user, :opposite => :plan
  embeds_many :activities

  validates :user, :presence => true
end