class ArticleVeneer < ApplicationRecord
  belongs_to :article
  belongs_to :veneer

  delegate :host, to: :veneer
  alias_method :name, :host
end
