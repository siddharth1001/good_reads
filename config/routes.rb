Rails.application.routes.draw do
  get 'user/info', to:'user#info'
	# match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user

	devise_for :users
	root 'books#index'
	resources :books do
		resources :reviews
	end

end
