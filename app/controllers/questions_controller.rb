class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show ]

  before_action :find_question, only: %i[show destroy update]
  after_action :publish_question, only: :create

  def index
    @questions = Question.all
  end

  def show
    gon.question_id = @question.id
    @answers = @question.answers.where.not(id: @question.best_answer)
    ActionCable.server.broadcast("question_#{ @question.id}","question_number -#{ @question.id}"
    )
  end

  def new
    @question = current_user.questions.new
    @question.build_reward
  end

  def update
    if @question.user?(current_user)
      @question.update(question_params)
      flash[:notice] = 'Your question has been successfully edited.'
    end
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
    if @question.user?(current_user)
      @question.destroy
      redirect_to questions_path, notice: 'Your question has been successfully deleted'
    else
      redirect_to questions_path, alert: "You can't delete someone else's question"
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, files: [],
                    reward_attributes: [:name, :image], links_attributes: [:name, :url])
  end

  def find_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def publish_question
    # return if @question.errors.present?

    #   ActionCable.server.broadcast('questions',ApplicationController.render(partial: 'questions/question_channel',
    #     locals: { question: @question }
    #   )
    #   )
  end
end
