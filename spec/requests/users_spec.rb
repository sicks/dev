require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /user/new" do
    context "when no users exist" do
      before { get new_user_path }

      it { expect(response).to have_http_status :ok }
    end

    context "when a user exists" do
      let!(:user) { create(:user) }

      before { get new_user_path }

      it { expect(response).to redirect_to new_session_path }
    end
  end

  describe "GET /user/edit" do
    context "without current user" do
      before { get edit_user_path }

      it { expect(response).to redirect_to new_session_path }
    end

    context "with current user" do
      let!(:user) { create(:user) }
      let!(:session) { create(:session, user:) }

      before do
        authenticate(session)
        get edit_user_path
      end

      it { expect(response).to have_http_status :ok }
      it { expect(response).not_to redirect_to new_session_path }
    end
  end

  describe "POST /user" do
    let(:params) do
      {
        user: {
          email_address: "owner@email.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end

    context "when no users exist" do
      before { post user_path, params:  }

      it { expect(response).to redirect_to root_path }
    end

    context "when a user exists" do
      let!(:user) { create(:user) }

      before { get new_user_path }

      it { expect(response).to redirect_to new_session_path }
    end
  end

  describe "PUT /user" do
    let(:params) do
      { user: { email_address: "different@email.com" } }
    end

    context "without authentication" do
      before { put user_path, params: }

      it { expect(response).to redirect_to new_session_path }
    end

    context "when a user exists" do
      let!(:user) { create(:user) }
      let!(:session) { create(:session, user:) }

      before do
        authenticate(session)
        put user_path, params:
      end

      it { expect(response).to redirect_to edit_user_path }
      it { expect(user.reload.email_address).to eq "different@email.com" }
    end
  end
end
