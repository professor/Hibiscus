Factory.define(:katacomment) do |k|
  k.recommendation "Recommend"
  k.timeSpent "5 hours"
  k.good "Algorithm"
  k.bad "Nothing"
  k.language "Ruby"
  k.ahhah "None"
  k.association :user
  k.association :post
end