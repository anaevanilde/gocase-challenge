Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :orders, only: [:create, :index] do
        collection do
          get :get_status
        end
      end

      resources :batches, only: [:create] do
        post :produce, on: :member
        post :close_by_delivery_service, on: :member
      end
    end
  end

end
