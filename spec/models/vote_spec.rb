# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:votable) }
  it { should validate_presence_of(:body) }

  describe 'validations' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let!(:vote) { create(:vote, author: user, votable: question) }

    it 'is not valid if user has already voted for the votable' do
      new_vote = Vote.create(body: 'up', author: user, votable: question)

      expect(new_vote).not_to be_valid
      expect(new_vote.errors[:vote]).to include('Вы уже проголосовали')
    end
  end
end
