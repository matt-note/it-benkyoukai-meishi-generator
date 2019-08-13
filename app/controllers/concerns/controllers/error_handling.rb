# frozen_string_litera: true

module Controllers
  module ErrorHandling
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError, with: :render_500
      rescue_from ActiveRecord::RecordNotFound, with: :render_404
      rescue_from ActionController::RoutingError, with: :render_404
    end

    def routing_error
      raise ActionController::RoutingError, "No route matches #{request.path.inspect}"
    end

    private
      def render_500(ex = nil)
        logger.error ex.message if ex
        respond_to do |format|
          format.html { render template: "errors/500", status: 500 }
        end
      end

      def render_404(ex = nil)
        logger.warn ex.message if ex
        respond_to do |format|
          format.html { render template: "errors/404", status: 404 }
        end
      end
  end
end
