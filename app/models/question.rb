class Question < ApplicationRecord
  include QuestionAnswer
  include Linkable

  has_many :answers, dependent: :destroy

  has_one :reward, dependent: :destroy

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true
end
