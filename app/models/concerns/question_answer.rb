# frozen_string_literal: true

module QuestionAnswer
  extend ActiveSupport::Concern

  included do
    has_many_attached :files
    has_many :comments, dependent: :destroy, as: :commentable

    def user?(user)
      author == user
    end
  end
end
