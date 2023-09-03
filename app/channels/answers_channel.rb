class AnswersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_#{params[:question_id]}"
  end

  def unsubscribed
    stop_all_streams
  end
end
