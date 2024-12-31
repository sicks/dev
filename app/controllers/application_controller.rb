class ApplicationController < ActionController::Base
  include Authentication
  include ErrorHandler
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_menu_tags

  def set_menu_tags
    @menu_tags = if authenticated?
      ActsAsTaggableOn::Tag.order(taggings_count: :desc).where("taggings_count > 0")
    else
      Article.published_tags
    end
  end
end
