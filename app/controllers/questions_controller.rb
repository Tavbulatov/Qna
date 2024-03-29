# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  before_action :find_question, only: %i[show destroy update]
  before_action :set_gon_user_id, only: %i[index create show]

  after_action :publish_question, only: :create
  authorize_resource

  def index
    @questions = Question.all
  end

  def show
    gon.question_id = @question.id
    @answers = @question.answers.where.not(id: @question.best_answer)
  end

  def new
    @question = current_user.questions.new
    @question.build_reward
  end

  def update
    @question.update(question_params)
    flash[:notice] = 'Your question has been successfully edited.'
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to questions_path, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Your question has been successfully deleted'
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                                                    reward_attributes: %i[name image], links_attributes: %i[name url])
  end

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def set_gon_user_id
    gon.current_user_id = current_user&.id
  end

  def publish_question
    return if @question.errors.present?

    ActionCable.server.broadcast('questions',
                                 ApplicationController.render(partial: 'questions/question_channel',
                                                              locals: { question: @question }))
  end
end
