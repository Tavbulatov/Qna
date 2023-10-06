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
    can :update, [Question], author_id: user.id
    can :destroy, [Question], author_id: user.id
  end

  def guest_abilities
    can :read, :all
  end
end
