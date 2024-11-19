class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :veneer
  delegate :user, to: :session, allow_nil: true
end
