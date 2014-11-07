class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
      cannot :release, Character do |character|
        character.user_id.blank?
      end
      cannot :claim, Character do |character|
        !character.user_id.blank?
      end
    elsif user.approved?
      can :update, CharacterEvent do |character_event|
        character = character_event.character
        character.user_id.blank? or character.user_id == user.id
      end
      can [:edit, :update], BossPreference do |boss_preference|
        character = boss_preference.character
        character.user_id.blank? or character.user_id == user.id
      end
      can :claim, Character do |character|
        character.user_id.blank? and
          (user.last_claim.blank? or user.last_claim < Time.now - 23.hours)
      end
      can [:release, :update], Character do |character|
        character.user_id == user.id
      end
      can :read, [Character, ComputedEvent, EventStatus]
    else
      # Guest users
      can :update, CharacterEvent do |character_event|
        character_event.character.user_id.blank?
      end
      can :update, BossPreference do |boss_preference|
        boss_preference.character.user_id.blank?
      end
      can :read, [Character, ComputedEvent, EventStatus]
    end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
