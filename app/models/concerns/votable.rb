# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable

    def vote_author(user)
      votes.where(author: user).first
    end

    def rating
      votes.where(body: 'up').count - votes.where(body: 'down').count
    end
  end
end
