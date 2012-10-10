FactoryGirl.define do
  factory :authentication do
    provider "Github"
    uid "123"
    association :user
  end
end