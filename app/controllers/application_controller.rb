class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound do |_|
    render json: { message: 'Record not found' }, status: 404
  end

  def render_success
    render json: { success: true }, status: 200
  end

end
