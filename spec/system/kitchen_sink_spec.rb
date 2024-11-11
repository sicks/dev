require 'rails_helper'

RSpec.describe "Kitchen Sink", type: :system do
  describe "Test Page" do
    it "renders the content" do
      visit "/kitchen/sink"

      expect(page).to have_css("h1", text: "Header")
      expect(page).to have_css("h2", text: "Header")
      expect(page).to have_css("h3", text: "Header")
      expect(page).to have_css("h4", text: "Header")
      expect(page).to have_css("h5", text: "Header")
      expect(page).to have_css("h6", text: "Header")
      expect(page).to have_css("p", count: 11)
      expect(page).to have_css("ul")
      expect(page).to have_css("ul li", count: 3)
      expect(page).to have_css("ol")
      expect(page).to have_css("ol li", count: 3)
      expect(page).to have_css("pre code")
      expect(page).to have_css("a", count: 2)
      expect(page).to have_css("button")
    end

    specify "flash messages" do
      visit "/kitchen/sink"

      find(".btn.notice").click
      expect(page).to have_css("#flash .message.notice", text: "Notice type flash message")
      find(".btn.success").click
      expect(page).to have_css("#flash .message.success", text: "Success type flash message")
      find(".btn.alert").click
      expect(page).to have_css("#flash .message.alert", text: "Alert type flash message")
      find(".btn.error").click
      expect(page).to have_css("#flash .message.error", text: "Error type flash message")
    end
  end
end
