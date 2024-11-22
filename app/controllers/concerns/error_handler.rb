module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |error|
      @http_code = status_code
      @message = error.message

      respond_to do |format|
        format.turbo_stream do
          flash.now[:error] = @message
          render "application/error", status:
        end
        format.json do
          render "application/error", status:
        end
        format.html do
          render "application/error", status:
        end
      end
    end
  end

  def status
    ActionDispatch::ExceptionWrapper.rescue_responses[$!.class.name]
  end

  def status_code
    ActionDispatch::ExceptionWrapper.status_code_for_exception($!.class.name)
  end
end
