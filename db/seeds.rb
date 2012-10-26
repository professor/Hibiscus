# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require 'factory_girl'

FactoryGirl.define do
  factory :user, class: User do
    #can default values here
  end

  factory :scotty, :parent => :user do
    name "Scotty Dog"
    username "scotty"
    email "todd.sedano@sv.cmu.edu"
  end
end

todd = FactoryGirl.create(:scotty)
