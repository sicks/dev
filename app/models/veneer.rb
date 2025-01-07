class Veneer < ApplicationRecord
  validates :host, :title, :subtitle, presence: true
  validates :theme, inclusion: { in: %w[light dark] }

  has_many :article_veneers
  has_many :articles, through: :article_veneers

  class << self
    def default(host)
      Veneer.new(host:)
    end
  end
end
