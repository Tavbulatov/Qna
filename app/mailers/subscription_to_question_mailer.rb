# frozen_string_literal: true

class SubscriptionToQuestionMailer < ApplicationMailer
  def new_answer_notification(user, question)
    @question = question

    mail to: user.email
  end
end
