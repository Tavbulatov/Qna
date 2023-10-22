class SubscriptionToQuestionJob < ApplicationJob
  queue_as :default

  def perform(question)
    SubscriptionToQuestion.new.send_notification(question)
  end
end
