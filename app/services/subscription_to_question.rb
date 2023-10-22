class SubscriptionToQuestion
  def send_notification(question)
    users = question.subscribed_users

    users.each do |user|
      SubscriptionToQuestionMailer.new_answer_notification(user, question).deliver_later
    end
  end
end
