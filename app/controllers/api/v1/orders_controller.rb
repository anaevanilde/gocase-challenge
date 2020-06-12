class Api::V1::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    byebug
    if Order.create(order_params)
      render_success
    else
      render json: { success: false }, status: :bad_request
    end
  end

  private

    def order_params
      params.require(:order).permit(
        :id, :address, :client_name, :delivery_service, :reference,
        :status, :total_value, line_items: []
      )
    end
end
