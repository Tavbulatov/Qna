class Subscription < ApplicationRecord
  belongs_to :subscribed_question, class_name: 'Question'
  belongs_to :subscribed_user, class_name: 'User'

  validates :subscribed_user, uniqueness: { scope: :subscribed_question }
end
