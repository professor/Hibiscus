Factory.define(:authentication) do |a|
  a.provider "Github"
  a.uid "123"
  a.association :user
end