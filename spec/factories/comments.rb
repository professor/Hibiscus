FactoryGirl.define do
  factory :comment do
    content "Comment Content Factory"
    association :user
    association :post
  end
end