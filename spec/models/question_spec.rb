# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should have_many(:answers).dependent(:destroy) }
  it { should have_many(:links).dependent(:destroy) }

  it { should have_one(:reward).dependent(:destroy) }

  it { should have_many_attached(:files) }

  it { should belong_to(:author).class_name('User') }
  it { should belong_to(:best_answer).class_name('Answer').optional(true) }

  it { should accept_nested_attributes_for(:reward).allow_destroy(true) }
  it { should accept_nested_attributes_for(:links).allow_destroy(true) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  it { should have_many(:subscriptions).dependent(:destroy) }
  it { should have_many(:subscribed_users).through(:subscriptions) }

  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }

  it { expect(question.user?(user)).to eq(true) }

  let!(:links) { create_list(:link, 2, linkable: question) }
  let!(:link_gists) { create_list(:link, 2, :url_gist, linkable: question) }
  let!(:vote) { create(:vote, author: user, votable: question) }

  let(:resource) { question }
  it_behaves_like 'gists extract from links'

  context 'vote_author' do
    it { expect(question.vote_author(user)).to eq(vote) }
  end

  context 'rating' do
    it { expect(question.rating).to eq(0) }
  end
end
