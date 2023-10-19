# frozen_string_literal: true

class Answer < ApplicationRecord
  include QuestionAnswer
  include Linkable
  include Votable

  belongs_to :question
  belongs_to :author, class_name: 'User'

  validates :body, presence: true
end
