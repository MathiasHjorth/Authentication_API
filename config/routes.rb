Rails.application.routes.draw do

  #User
  #overwriting out the box devise routes to our own custom controllers:
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {sessions: 'api/v1/sessions', registrations: 'api/v1/users'}

  #Product
  get 'api/v1/products', to: 'api/v1/products#index'

  #Shopping_basket
  get 'api/v1/shopping_baskets', to: 'api/v1/shopping_baskets#show'
  post 'api/v1/shopping_baskets', to: 'api/v1/shopping_baskets#create'
  delete 'api/v1/shopping_baskets/delete/all', to: 'api/v1/shopping_baskets#destroy'
  delete 'api/v1/shopping_baskets/delete/:product_id', to: 'api/v1/shopping_baskets#delete'



end
