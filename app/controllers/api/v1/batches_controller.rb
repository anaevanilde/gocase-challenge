class Api::V1::BatchesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @batch = Batch.create(batch_params)
    if @batch.persisted?
      render json: {reference: @batch.reference, included_orders: @batch.orders.count}
    else
      render json: @batch.errors.as_json, status: :bad_request
    end
  end

  def produce
    orders_affected = Batch.find(params[:id]).orders.update_all(status: 'closing')
    render json: {orders_affected: orders_affected}
  end

  def close_by_delivery_service
    orders_affected = Batch.find(params[:id])
                           .orders
                           .where('lower(delivery_service) = ?', params[:delivery_service]&.downcase)
                           .update_all(status: 'sent')

    render json: {orders_affected: orders_affected}
  end

  private
    def batch_params
       params.require(:batch).permit(:purchase_channel)
    end
end
