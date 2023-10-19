# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, author: user) }

  describe 'POST #create' do
    before { login(user) }

    it 'create vote' do
      expect do
        post :create, params: { question_id: question, votable: 'Question', vote: { body: 'up' } },
                      format: :json
      end.to change(Vote, :count).by(1)
    end

    it 'sets a flash message' do
      post :create, params: { question_id: question, votable: 'Question', vote: { body: 'up' } }, format: :json

      expect(flash[:notice]).to eq('Your vote has been counted')
    end
  end

  describe 'POST #destroy' do
    before { login(user) }

    let!(:vote) { create(:vote, votable: question, author: user) }

    it 'destroy vote' do
      expect { delete :destroy, params: { id: vote }, format: :json }.to change(Vote, :count).by(-1)
    end

    it 'sets a flash message' do
      delete :destroy, params: { id: vote }, format: :json

      expect(flash[:notice]).to eq('You deleted your vote')
    end
  end
end
