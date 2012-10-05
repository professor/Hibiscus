require "searchify"

namespace :hibiscus do

  desc 'Creates indexes needed by this system'
  task :setup_search_indexes do |t, args|
    Searchify.setup_indexes
  end

  desc 'Iterate through all page objects and store content in searchify'
  task :update_search_index do |t, args|
    Post.all.each do |post|
      post.update_search_index
    end
  end

end