require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:author) { create(:author) }

  describe ".scopes" do
    describe ".published" do
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

    describe ".with_tags(tags)" do
      let!(:no_tags) { create(:article, author:) }
      let!(:foo) { create(:article, author:, tag_list: "foo") }
      let!(:foo_bar) { create(:article, author:, tag_list: "foo, bar") }
      let!(:bar_baz) { create(:article, author:, tag_list: "bar, baz") }

      context "with one tag" do
        it "includes articles with that tag" do
          expect(Article.with_tags(["foo"])).to include(foo, foo_bar)
        end

        it "does not include articles without that tag" do
          expect(Article.with_tags(["foo"])).not_to include(no_tags, bar_baz)
        end
      end

      context "with multiple tags" do
        it "includes articles with either tag" do
          expect(Article.with_tags(["foo", "bar"])).to include(foo, foo_bar, bar_baz)
        end

        it "does not include articles without any of those tag" do
          expect(Article.with_tags(["bar", "baz"])).not_to include(no_tags, foo)
        end
      end
    end
  end
end
