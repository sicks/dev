FactoryBot.define do
  factory :veneer do
    host { %w[localhost 127.0.0.1].sample }
    title { "website/name" }
    subtitle { "This is a website" }
    theme { %w[dark light].sample }
  end
end
