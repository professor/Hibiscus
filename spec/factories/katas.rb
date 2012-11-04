FactoryGirl.define do
  factory :kata do
    title "Kata Title Factory"
    content "Kata Content Factory"
    association :user
    association :category
    challenge_level "Medium"
    rating 4
  end
end