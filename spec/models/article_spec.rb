require 'rails_helper'

RSpec.describe Article, type: :model do
  describe ".scopes" do
    describe ".published" do
      let(:author) { create(:author) }
      let!(:pre_published) { create(:article, author:, published_at: 3.days.ago) }
      let!(:not_published) { create(:article, author:, published_at: nil) }
      let!(:post_published) { create(:article, author:, published_at: 3.days.from_now) }

      it "includes published articles" do
        expect(Article.published).to include(pre_published)
      end

      it "does not include unpublished articles" do
        expect(Article.published).not_to include(not_published)
      end

      it "does not include future published articles" do
        expect(Article.published).not_to include(post_published)
      end
    end
  end
end
