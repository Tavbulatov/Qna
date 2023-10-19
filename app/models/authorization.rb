# frozen_string_literal: true

class Authorization < ApplicationRecord
  belongs_to :user

  validates :provider, :uid, presence: true

  def confirmed?
    confirmed_at
  end

  def confirm!
    update(confirmed_at: Date.current)
  end
end
