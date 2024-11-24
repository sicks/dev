class Article < ApplicationRecord
  include MarkdownConverter

  belongs_to :author, class_name: "User"

  acts_as_taggable_on :tags

  before_save :markdown_to_html, if: :markdown_changed?

  private

  def markdown_to_html
    self.html = converter.render(markdown)
  end
end
