FactoryGirl.define do
  factory :article do
    id "retrospective-principles"
    title "Retrospective Principles"
    content "Retrospective Principles"
    association :user
    site_name "George Dinwiddie blog"
  end

end