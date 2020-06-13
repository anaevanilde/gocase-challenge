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

  # Get order status by reference or client name
  def get_status
    if params[:reference].present?
      @orders = Order.get_status_attributes
                     .where(reference: params[:reference])
    else
      @orders = Order.get_status_attributes
                     .where('lower(client_name) = ?', params[:client_name]&.downcase)
                     .order(:created_at)
                     .page(params[:page][:number])
                     .per(3)
    end
  end

  private

    def order_params
      permitted_params = params.require(:order).permit(
        :id, :address, :client_name, :delivery_service, :reference,
        :status, :total_value
      )
      permitted_params[:line_items] = params[:order][:line_items]&.to_a

      permitted_params.permit!
    end
end
