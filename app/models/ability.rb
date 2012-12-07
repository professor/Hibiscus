# This model declares permissions for managing resources.

class Ability
  include CanCan::Ability

  # Initialize the different permissions with respect to the attributes of the user parameter.
  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # Create a placeholder User instance to allow access by users who are not logged in.
    user ||= User.new

    if user.admin?
      # A user who is an admin can perform any action on all the resources.
      can :manage, :all
    else
      # All other users can perform show and index actions unless otherwise restricted.
      can :read, :all
    end

    # A logged in user can perform update and destroy actions on resources that he created.
    can [:update, :destroy], [Kata, Post, Article, Comment, Review], :user_id => user.id

    # A logged in user can perform any action on his own profile.
    can :manage, User, :id => user.id
  end
end