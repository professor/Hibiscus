FactoryGirl.define do
  factory :activity do
    name "Programming Project"
    association :plan
  end
end