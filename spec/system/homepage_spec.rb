require "rails_helper"

RSpec.describe "Homepage", type: :system do
  it "passes" do
    visit root_path
    expect(page).to have_content "Hello World"
  end

  it "fails with a screeenshot" do
    visit root_path
    expect(page).not_to have_content "Hello World"
  end
end
