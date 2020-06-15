class ApplicationController < ActionController::Base

  rescue_from ActiveRecord::RecordNotFound do |_|
    render json: { message: 'Record not found' }, status: 404
  end

  rescue_from ArgumentError do |e|
    render json: { message: e.message }, status: 400
  end
end
