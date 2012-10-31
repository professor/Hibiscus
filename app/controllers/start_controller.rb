class StartController < ApplicationController
  def show
    @easy_kata1 = Post.find 'string-calculator'
    @easy_kata2 = Post.find 'coin-change-kata'
    @easy_kata3 = Post.find 'prime-factors-kata'
  end
end
