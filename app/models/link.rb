class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp, message: "Invalid URL format" }

  def gist?
    self.url.include?('gist.github')
  end
end