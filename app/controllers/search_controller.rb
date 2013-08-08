require 'open-uri'

##
# This class works as a controller for Craftsmanship search.
class SearchController < ApplicationController

  ##
  # Connect to IndexTank and get the index for Craftsmanship posts and Katas
  def self.index_tank
    @api  = IndexTank::Client.new(ENV['SEARCHIFY_HIBISCUS_API_URL'] || 'http://your_api_url')
    @index ||= @api.indexes(ENV['SEARCHIFY_HIBISCUS_INDEX'] || 'hibiscus')
  end

  ##
  # Search contents by a +query+ from the Indextank index. Return index docs.
  def self.search(query)
    query = query.gsub(/\W+/,' ').strip

    if query.present?
      query << "*"
      index_tank.search("#{query} OR title:#{query}", :fetch => 'timestamp,url,text,title', :snippet => 'text')
    end
  end

  ##
  # Search Craftsmanship contents by the url argument 'query'. Return index docs.
  def index
    @docs = SearchController.search(params[:query]) if params[:query].present?
  end
end
