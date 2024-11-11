require 'rails_helper'

RSpec.describe "Kitchen Sink", type: :request do
  describe "GET /show" do
    before { get "/kitchen/sink" }

    it { expect(response).to have_http_status(:ok) }
  end

  describe "POST /create" do
    before { get "/kitchen/sink", params: { commit: :notice } }

    it { expect(response).to have_http_status(:ok) }
  end
end
