module QuestionAnswer
  extend ActiveSupport::Concern

  included do
    has_many_attached :files

    def user?(user)
      author == user
    end
  end
end
