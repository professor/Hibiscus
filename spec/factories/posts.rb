Factory.define :post do |p|
  p.title "Post Title Factory"
  p.content "Post Content Factory"
  p.association :user
end