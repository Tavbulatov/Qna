module QuestionAnswer
  extend ActiveSupport::Concern

  included do
    has_many_attached :files

    def user?(user)
      author == user
    end

    def gists_url
      gists.pluck('url')
    end

    def gists_id
      gists.map(&:id)
    end

    def gists
      links.select { |l| l.gist? }
    end
  end
end
