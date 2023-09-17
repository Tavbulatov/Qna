class AnswersController < ApplicationController
  before_action :find_answer, only: %i[destroy update best]
  before_action :authenticate_user!

  after_action :publish_answer, only: :create

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.create(answer_params.merge(author: current_user ))
    if @answer.persisted?
      flash[:notice] = 'Answer created successfully'
    end
  end

  def update
    if @answer.user?(current_user)
      @answer.update(answer_params)
      flash[:notice] = 'Answer edited successfully'
    end
  end

  def destroy
    if @answer.author == current_user
      @answer.destroy
      flash[:notice] = 'Your reply has been successfully deleted'
    else
      flash[:alert] = "You cannot delete someone else's answer"
    end
  end

  def best
    question = @answer.question
    question.update(best_answer: @answer)

    @best_answer = question.best_answer
    @best_answer.author.rewards.push(question.reward) if question.reward

    @answers = question.answers.where.not(id: @best_answer.id)

    flash[:notice] = 'Best answer selected successfully'
  end

  private

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: [:name, :url])
  end

  def find_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def publish_answer
    return if @answer.errors.present?

    ActionCable.server.broadcast("question_#{@question.id}",
      ApplicationController.render(partial: 'answers/answer_channel',
      locals: { answer: @answer, authenticity_token: form_authenticity_token })
    )
  end
end
