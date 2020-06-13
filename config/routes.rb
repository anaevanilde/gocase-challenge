Rails.application.routes.draw do

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :orders, only: [:create] do
        collection do
          get :get_status
        end
      end
    end
  end

end
