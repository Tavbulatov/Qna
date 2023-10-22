# frozen_string_literal: true

class Question < ApplicationRecord
  include QuestionAnswer
  include Linkable
  include Votable

  has_many :answers, dependent: :destroy

  has_one :reward, dependent: :destroy

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many :subscriptions, foreign_key: 'subscribed_question_id', dependent: :destroy
  has_many :subscribed_users, through: :subscriptions

  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true

  after_create :subscribe_author

  private

  def subscribe_author
    Subscription.create(subscribed_user: author, subscribed_question: self)
  end
end
