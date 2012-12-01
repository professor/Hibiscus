FactoryGirl.define do
  factory :post do
    title "Post Title Factory"
    content "Post Content Factory"
    association :user,  strategy: :build
  end
end