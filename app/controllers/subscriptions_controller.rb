# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def subscribe
    current_user.subscribed_questions.push(Question.find(params[:id]))
  end

  def unsubscribe
    question = Question.find(params[:id])
    Subscription.find_by(subscribed_user: current_user, subscribed_question: question).destroy
  end
end
