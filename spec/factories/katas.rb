FactoryGirl.define do
  factory :kata do
    title "Kata Title Factory"
    content "Kata Content Factory"
    association :user
    association :category
    challenge_level "medium"
  end
end

#Factory.define :kata do |ak|
#  k.title "Kata Title Factory"
#  k.content "Kata Content Factory"
#  k.association :user
#  k.association :category
#  k.challenge_level "medium"
#end