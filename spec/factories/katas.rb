FactoryGirl.define do
  factory :kata do
    title "Kata Title Factory"
    content "Kata Content Factory"
    challenge_level "Medium"
    rating 4
    category_ids ['others']
    association :user
  end
end