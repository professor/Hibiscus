class Plan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :maiden_speech, :type => String, :default => "For me Software Craftsmanship includes the notion of 'X'. I want to
get better at 'X'. What does the community think will help me improve in this area? "

  embedded_in :user, :inverse_of => :plan

  validates :user, :presence => true
end