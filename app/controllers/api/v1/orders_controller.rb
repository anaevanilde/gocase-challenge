class Api::V1::OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @order = Order.create(order_params)
    if @order.persisted?
      render json: { reference: @order.reference}, status: :ok
    else
      render json: @order.errors.as_json, status: :bad_request
    end
  end

  # Get order status by reference or client name
  def get_status
    @orders = Order.get_status_attributes
                   .where(reference: params[:reference])

    return if @orders.present?

    @orders = Order.get_status_attributes
                   .where('lower(client_name) = ?', params[:client_name]&.downcase)
                   .order(created_at: :desc)
                   .page(params[:page][:number])
                   .per(3)

    raise ActiveRecord::RecordNotFound if @orders.empty?
  end

  def index
    if params[:status].present?
      @orders = Order.where(
        'lower(purchase_channel) = ? AND status = ?',
        params[:purchase_channel]&.downcase, params[:status]
      ).order(created_at: :asc)
    else
      @orders = Order.get_status_attributes
                     .where('lower(client_name) = ?', params[:client_name]&.downcase)
                     .order(:created_at)
                     .page(params[:page][:number])
                     .per(3)
    end

    raise ActiveRecord::RecordNotFound if @orders.empty?
  end

  private

    def order_params
      params.require(:order).permit(
        :id, :address, :client_name, :delivery_service, :reference,
        :status, :total_value, :purchase_channel, line_items_attributes: [:sku, specifications: {}]
      )
    end
end
