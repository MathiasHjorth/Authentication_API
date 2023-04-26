Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  #overwriting out the box devise routes to our own custom controllers:
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },
             controllers: {sessions: 'api/v1/sessions', registrations: 'api/v1/users'}

  get 'api/v1/products', to: 'api/v1/products#index'

end
