require 'indextank'

# Kata is a model inherited from Post model.
#
# The reason to do inheritance is because Kata shares most of fields
# with Post and also has some extra fields.

class Kata < Post

  field :challenge_level, :type => String
  field :user_categories, :type => String

  belongs_to :category

  # challenge_level can be "low", "medium", "high"
  validates :challenge_level, presence: true, inclusion: { in: %w(low medium high) }
  # a kata must have one and only one category
  validates :category, presence: true

end