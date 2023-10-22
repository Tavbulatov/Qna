# frozen_string_literal: true

class DailyDigestMailer < ApplicationMailer
  def digest(user)
    @questions = Question.where(created_at: 24.hours.ago..Time.now)

    mail to: user.email
  end
end
