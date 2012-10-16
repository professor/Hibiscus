FactoryGirl.define do
  factory :plan do
    maiden_speech "I'd love to learn about Ruby programming."
    association :user
    end
end