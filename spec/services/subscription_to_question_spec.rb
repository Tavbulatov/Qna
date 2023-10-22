# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionToQuestion, type: :service do
  describe '#send_notification' do
    let!(:question) { create(:question) }
    let!(:subscription1) do
      create(:subscription,  subscribed_question: question,
                             subscribed_user: create(:user))
    end
    let!(:subscription2) do
      create(:subscription,  subscribed_question: question,
                             subscribed_user: create(:user))
    end

    let!(:users) { question.subscribed_users }

    it 'sends a new answer notification to all subscribers' do
      users.each do |user|
        expect(SubscriptionToQuestionMailer).to receive(:new_answer_notification).with(user, question).and_call_original
      end
      SubscriptionToQuestion.new.send_notification(question)
    end
  end
end
