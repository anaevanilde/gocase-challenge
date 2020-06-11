class GocaseOrdersManagement::V1::OrdersController < ApplicationController
  def create
    if Order.create(order_params)
      render_success
    else
      render json: { success: false }, status: :bad_request
    end
  end

  private

    def order_params
      params.require(:orders).permit(
        :id, :address, :client_name, :delivery_service, :line_items, :reference,
        :status, :total_value
      )
    end
end
