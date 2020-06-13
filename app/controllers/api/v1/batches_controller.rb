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

  private
    def batch_params
       params.require(:batch).permit(:purchase_channel)
    end
end
