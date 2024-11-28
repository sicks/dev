class Article < ApplicationRecord
  extend FriendlyId
  include MarkdownConverter

  belongs_to :author, class_name: "User"

  scope :published, ->{ where("published_at < ?", Time.current) }

  before_save :markdown_to_html, if: :markdown_changed?

  acts_as_taggable_on :tags
  friendly_id :title, use: :slugged

  def unpublished?
    return true unless published_at

    published_at > Time.current
  end

  private

  def markdown_to_html
    self.html = converter.render(markdown)
  end
end
