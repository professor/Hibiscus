Factory.define :post do |p|
  p.title "Post Title Factory"
  p.content "Post Content Factory"
  p.isKata false
  p.association :user
end