Factory.define :kata do |k|
  k.title "Kata Title Factory"
  k.content "Kata Content Factory"
  k.association :user
  k.association :category
  k.challenge_level "medium"
end