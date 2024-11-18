require 'rails_helper'

RSpec.describe "Kitchen Sink", type: :system do
  describe "Test Page" do
    it "renders the content" do
      visit "/kitchen/sink"

      expect(page).to have_css(".kitchen-sink h1", text: "Kitchen Sink")
      expect(page).to have_css(".kitchen-sink h2", text: "Headers")
      expect(page).to have_css(".kitchen-sink h3", text: "Header 3")
      expect(page).to have_css(".kitchen-sink h4", text: "Header 4")
      expect(page).to have_css(".kitchen-sink h5", text: "Header 5")
      expect(page).to have_css(".kitchen-sink h6", text: "Header 6")
      expect(page).to have_css(".kitchen-sink p", count: 5)
      expect(page).to have_css(".kitchen-sink ul")
      expect(page).to have_css(".kitchen-sink ul li", count: 3)
      expect(page).to have_css(".kitchen-sink ol")
      expect(page).to have_css(".kitchen-sink ol li", count: 3)
      expect(page).to have_css(".kitchen-sink pre code")
      expect(page).to have_css(".kitchen-sink a", count: 2)
      expect(page).to have_css(".kitchen-sink button")
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
