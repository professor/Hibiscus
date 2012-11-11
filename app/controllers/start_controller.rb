# StartController handles view for Get Started page.
class StartController < ApplicationController
  ##
  # Retrieve 3 easy katas for Get Started page.
  def show
    @easy_katas = Kata.where(challenge_level:"Low").limit(3)
  end
end
