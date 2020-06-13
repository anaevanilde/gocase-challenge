Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :orders, only: [:create, :index] do
        collection do
          get :get_status
        end
      end

      resources :batches, only: [:create]
    end
  end

end
