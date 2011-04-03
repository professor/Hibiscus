Factory.define(:like) do |l|
  l.association :post
  l.association :user
end