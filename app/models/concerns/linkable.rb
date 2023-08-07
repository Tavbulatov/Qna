module Linkable
  extend ActiveSupport::Concern

  included do
    has_many :links, dependent: :destroy, as: :linkable
    accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

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
