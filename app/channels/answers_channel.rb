class AnswersChannel < ApplicationCable::Channel
  def follow
    stream_from "question_#{params[:question_id]}"
  end

  def unfollow
    stop_all_streams
  end
end
