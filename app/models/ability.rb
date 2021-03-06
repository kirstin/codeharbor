class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.role == 'admin'
        can :manage, :all
      elsif user.role == 'teacher'
        can :show, Exercise
        can :create, Exercise
        can :duplicate, Exercise
        can :export, Exercise
        can :add_to_cart, Exercise
        can :read, Exercise
        can :manage, Exercise do |exercise|
          exercise.user == user
        end

        can :show, Comment
        can :create, Comment
        can :read, Comment
        can :edit, Comment do |comment|
          comment.user == user
        end

        can :read, Test
        can :read, ExerciseFile
        can :create, Rating

        can :manage, User do |_user|
          _user == user
        end
      elsif user.role == 'user'
        can :read, Exercise
        can :read, Rating
        can :read, Comment
        can :manage, User do |_user|
          _user == user
        end
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
