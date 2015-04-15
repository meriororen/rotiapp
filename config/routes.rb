Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  devise_for :users, :controllers => { :sessions => "api/sessions" }
  root :to => 'home#index'
	
	namespace :api, defaults: {format: :json} do
    devise_scope :user do
      resource :session, only: [:create, :destroy]
    end
		resources :rotis, only: [:index, :create, :update, :destroy] 
    resources :roti_sales, only: [:index, :create, :update, :destroy]
    resources :sales, only: [:index, :create, :update, :destroy]
    resources :lokasis, only: [:index, :create, :update, :destroy]
	end

  get '/dashboard' => 'templates#index'
  get '/rotis' => 'templates#index'
  get '/lokasis' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/ }
end
