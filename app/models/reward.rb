# frozen_string_literal: true

class Reward < ApplicationRecord
  has_one_attached :image

  belongs_to :question
  belongs_to :user, optional: true

  validates :name, :image, presence: true
end
