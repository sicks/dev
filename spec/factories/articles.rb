FactoryBot.define do
  factory :article do
    sequence(:title) { |i| "Test article #{i}" }
    markdown { "## Header 2" }
    author
  end
end
