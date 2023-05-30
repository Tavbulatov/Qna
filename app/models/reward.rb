class Reward < ApplicationRecord
  has_one_attached :image

  belongs_to :question
  belongs_to :user, optional: true
end
