module ApiRoutes
  def self.extended(router)
    router.instance_exec do

      namespace :api, format: :json do
        namespace :v1 do
          post :login, to: "sessions#login"
          delete :logout, to: "sessions#logout"

          resources :wallets, only: [] do
            collection do
              get :balance
              post :transfer
            end
          end

          # HealthChecks
          get :ping, to: "health_checks#ping"
        end
      end

    end
  end
end
