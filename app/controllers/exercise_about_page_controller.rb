# ExerciseAboutPageController handles view for "/get_started" page. The words 'exercise' and 'kata'
# mean the same thing and are interchangeable. Currently, its only functionality is to provide
# some easy katas for beginners to play with. If more content needs to show on the get started page,
# they can be easily added here.

class ExerciseAboutPageController < ApplicationController
  ##
  # Called by the"/get_started" path (see routes.rb).
  # Provide 3 katas from low challenge level for users
  def show
    @easy_katas = Kata.where(challenge_level:"Low").limit(3)
  end
end
