FactoryGirl.define do
  factory :flag do
    association :post,  strategy: :build
    association :user,  strategy: :build
  end
end