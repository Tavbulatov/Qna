class Answer < ApplicationRecord
  include QuestionAnswer
  include Linkable

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true
end
