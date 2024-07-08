Rails.application.routes.draw do
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout'
             },
             controllers: {
               sessions: 'users/sessions'
             },
             defaults: { format: :json }

  resources :products, only: [:index, :show]

  resources :carts, only: :index do
    collection do
      post :add_product
      get :items_count
    end
  end
end
