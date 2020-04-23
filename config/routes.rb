Rails.application.routes.draw do
	root 'homepage#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	omniauth_callbacks: "users/omniauth_callbacks"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :classroom do
    get '/', to: "homepage#index"
  end

  resources :classrooms do
    resources :votes
  end
end
