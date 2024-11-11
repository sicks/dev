class KitchenController < ApplicationController
  allow_unauthenticated_access

  def show
  end

  def create
    type = params[:commit]
    flash.now[type] = "#{type.capitalize} type flash message"
  end
end
