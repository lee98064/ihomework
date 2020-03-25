Rails.application.routes.draw do
	root 'homepage#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
  	account_update: "users/registrations", 
  	sign_up: "users/registrations",
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
