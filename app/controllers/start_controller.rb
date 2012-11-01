class StartController < ApplicationController
  def show
    @easy_kata1 = Kata.find 'string-calculator'
    @easy_kata2 = Kata.find 'coin-change-kata'
    @easy_kata3 = Kata.find 'prime-factors-kata'
  end
end
