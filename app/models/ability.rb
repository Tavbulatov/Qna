# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    user ? user_abilities : guest_abilities
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer], author_id: user.id

    can :destroy, [Question, Answer, Comment], author_id: user.id
    can :destroy, Link, linkable: { author_id: user.id }

    can :best, Answer, question: { author_id: user.id }


    # can :create, Vote, votable: {author_id: user.id} do |vote|
    #   !vote.votable.user?(user)
    # end
  end

  def guest_abilities
    can :read, :all
  end
end
