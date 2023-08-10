class Vote < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :votable, polymorphic: true

  validates :body, presence: true
  validate :user_can_vote_once_per_votable, on: :create

  private

  def user_can_vote_once_per_votable
    if Vote.exists?(author: author, votable: votable, votable_type: votable_type)
      errors.add(:vote, "Вы уже проголосовали")
    end
  end
end
