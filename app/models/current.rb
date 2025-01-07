class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :veneer
  delegate :user, to: :session, allow_nil: true
  delegate :host, to: :veneer
end
