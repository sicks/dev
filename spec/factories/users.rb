FactoryBot.define do
  factory :user, aliases: [:author] do
    email_address { "owner@email.com" }
    password_digest { BCrypt::Password.create("password") }
  end
end
