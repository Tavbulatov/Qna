module QuestionAnswer
  extend ActiveSupport::Concern

  included do
    has_many_attached :files

    def user?(user)
      author == user
    end

    def gists
      links.select { |l| l.gist? }
    end

    def links_except_gists
      links.where.not(id: gists)
    end
  end
end
