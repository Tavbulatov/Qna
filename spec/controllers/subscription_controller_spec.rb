# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  describe 'POST #subscribe' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }

    before do
      sign_in user
      post :subscribe, params: { id: question.id }
    end

    it 'subscribes the current user to the question' do
      expect(user.subscribed_questions).to include(question)
    end
  end

  describe 'DELETE #unsubscribe' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let!(:subscription) { create(:subscription, subscribed_user: user, subscribed_question: question) }

    before do
      sign_in user
      delete :unsubscribe, params: { id: question.id }
    end

    it 'destroys the subscription' do
      expect(Subscription.find_by(id: subscription.id)).to be_nil
    end
  end
end
