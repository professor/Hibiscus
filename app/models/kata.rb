require 'indextank'

class Kata < Post

  # == Kata Model
  # Kata is a model inherited from Post model.
  #

  field :challenge_level, :type => String # can be "low", "medium", "high"
  field :user_categories, :type => String

  belongs_to :category

  validates :challenge_level, presence: true, inclusion: { in: %w(low medium high) }
  validates :category, presence: true

end