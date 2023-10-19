# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }
    it { should be_able_to :read, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:question) { create(:question, author: user) }
    let(:answer) { create(:answer, author: user, question: question) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, question }
    it { should be_able_to :update, answer }

    it { should be_able_to :destroy, question }
    it { should be_able_to :destroy, answer }

    it { should be_able_to :destroy, create(:comment, commentable: question, author: user) }

    it { should be_able_to :best, answer }

    it { should be_able_to :me, user }

    it 'all' do
      user.update(admin: true)
      user.reload

      should be_able_to :all, user
    end
  end
end
