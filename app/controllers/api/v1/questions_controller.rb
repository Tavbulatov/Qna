# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < Api::V1::BaseController
      before_action :set_question, only: %i[show update destroy]
      respond_to :json

      def index
        respond_with Question.all, each_serializer: QuestionsSerializer
      end

      def show
        respond_with @question, serializer: QuestionSerializer
      end

      def create
        @question = current_resource_owner.questions.create(question_params)

        respond_with @question, serializer: QuestionSerializer
      end

      def update
        @question.update(question_params)

        render json: @question, serializer: QuestionSerializer
      end

      def destroy
        @question.destroy
      end

      private

      def set_question
        @question = Question.with_attached_files.find(params[:id])
      end

      def question_params
        params.require(:question).permit(:title, :body, files: [],
                                                        reward_attributes: %i[name image], links_attributes: %i[name url])
      end
    end
  end
end
