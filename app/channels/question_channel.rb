class QuestionChannel < ApplicationCable::Channel
  def follow
    stream_from "questions"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def connected
  end

  def received
  end
end
