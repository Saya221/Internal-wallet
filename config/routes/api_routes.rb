module ApiRoutes
  def self.extended(router)
    router.instance_exec do

      namespace :api, format: :json do
        namespace :v1 do
          post :login, to: "sessions#login"
          delete :logout, to: "sessions#logout"

          resources :wallets, only: %i[show] do
            collection do
              put :transfer
            end
          end

          resources :latest_stock_prices, only: [] do
            collection do
              get :price
              get :prices
              get :price_all
            end
          end

          # HealthChecks
          get :ping, to: "health_checks#ping"
        end
      end

    end
  end
end
