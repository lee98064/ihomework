Rails.application.routes.draw do
	root 'homepage#index'
  get '/about', to: 'homepage#about'
  mount RailsAdmin::Engine => '/backend', as: 'rails_admin'
  devise_for :users, controllers: {
  	registrations: 'users/registrations',
  	omniauth_callbacks: "users/omniauth_callbacks"
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :classrooms do
    collection do
      post :addcode
    end
    resources :posts
    resources :votes do
      post "/vote", to: "votes#vote", on: :member
    end
    resources :weeknotes,only: [:index,:show] do
      post "/create", to: "weeknotes#insert", on: :member
      get "/score",to: "weeknotes#score", on: :member
    end
    resources :members, only: [:index,:destroy]
    resources :scoresheets
    resources :testlists
  end

  namespace :admin do #管理
    resources :classrooms,except: [:index,:new,:create] do
      resources :posts
      resources :members
      resources :scoresheets,except: [:show,:new,:create]
      resources :weeknotes do
        member do
          get "checkpage"
          post "check"
        end
      end
    end
  end
  
end
