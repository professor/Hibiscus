FactoryGirl.define do
  factory :kata do
    title "Kata Title Factory"
    content "Kata Content Factory"
    challenge_level "Medium"
    rating 4
    association :user
    association :category
  end
end