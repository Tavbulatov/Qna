class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_#{params[:question_id]}"
  end

  def unsubscribed
  end

  def connected
  end

  def received
  end
end
