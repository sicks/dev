class KitchenController < ApplicationController
  allow_unauthenticated_access
  before_action :simulate_error

  def show
  end

  def create
    type = params[:commit]
    flash.now[type] = "#{type.capitalize} type flash message"
  end

  private

  def simulate_error
    case params[:id]
    when "not_found"
      raise ActiveRecord::RecordNotFound
    when "bad_request"
      raise ActionController::BadRequest
    end

    case params[:commit]
    when "error"
      raise ActiveRecord::RecordInvalid
    end
  end
end
