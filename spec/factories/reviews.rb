FactoryGirl.define do
  factory :review do  |r|

    title "test title"
    content "this is a test content for a review"
    rating 5
    challenge_level "low"
    language "Java"

    association :user
    association :kata,  strategy: :build
  end
end