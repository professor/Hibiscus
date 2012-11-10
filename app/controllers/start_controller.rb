class StartController < ApplicationController
  def show
    @easy_katas = Kata.where(challenge_level:"Low").limit(3)
  end
end
