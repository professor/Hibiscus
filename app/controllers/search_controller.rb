require 'open-uri'

class SearchController < ApplicationController

  def self.index_tank
    @api  = IndexTank::Client.new(ENV['INDEXTANK_API_URL'] || 'http://your_api_url')
    @index ||= @api.indexes('idx')
    @index
  end

  # retrieve docs from IndexTank
  def self.search(query)
    index_tank.search(query) #, :fetch=>'text,thumbnail_url,screen_name,plixi_id,timestamp')
  end

  def index
    @docs = SearchController.search(params[:query]) if params[:query].present?
  end
end
