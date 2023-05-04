Rails.application.routes.draw do

  #Users
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {sessions: 'api/v1/sessions', registrations: 'api/v1/users'}

  #Products
  get 'api/v1/products', to: 'api/v1/products#index'

  #Shopping_baskets
  get 'api/v1/shopping_baskets', to: 'api/v1/shopping_baskets#show'
  post 'api/v1/shopping_baskets', to: 'api/v1/shopping_baskets#create'
  delete 'api/v1/shopping_baskets/delete/all', to: 'api/v1/shopping_baskets#destroy'
  delete 'api/v1/shopping_baskets/delete/:product_id', to: 'api/v1/shopping_baskets#delete'

  #Orders
  get 'api/v1/orders', to: 'api/v1/orders#index'
  post 'api/v1/orders', to: 'api/v1/orders#create'

end
