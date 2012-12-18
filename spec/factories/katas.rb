FactoryGirl.define do
  factory :kata do
    title "Kata Title Factory"
    content "Kata Content Factory"
    challenge_level "Medium"
    rating 4
    categories {[FactoryGirl.create(:category)]}
    association :user
  end
end