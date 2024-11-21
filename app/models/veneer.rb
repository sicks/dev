class Veneer < ApplicationRecord
  validates :host, :title, :subtitle, presence: true
  validates :theme, inclusion: { in: %w[light dark] }

  class << self
    def default(host)
      Veneer.new(host:)
    end
  end
end
