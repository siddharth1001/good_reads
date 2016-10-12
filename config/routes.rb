Rails.application.routes.draw do
  # get 'user/info', to:'user#info'
  get 'user/:id' => 'users#info', as: :users
  match 'user/:id' => 'users#destroy', :via => :delete, :as => :destroy_user

	devise_for :users

	root 'books#index'
	resources :books do
		resources :reviews
	end

end
