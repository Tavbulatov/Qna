class Question < ApplicationRecord
  has_many :answers, dependent: :destroy

  has_one :reward, dependent: :destroy

  has_many_attached :files
  accepts_nested_attributes_for :reward

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  validates :title, :body, presence: true
end
