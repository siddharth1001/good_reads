# == Route Map
#
#                   Prefix Verb   URI Pattern                                Controller#Action
#                     user GET    /user/:id(.:format)                        users#registered_user
#             destroy_user DELETE /user/:id(.:format)                        users#destroy
#                    admin GET    /admin_user/:id(.:format)                  users#admin_user
#                moderator GET    /moderator_user/:id(.:format)              users#moderator_user
#                    users GET    /users(.:format)                           users#all_users
#                users_vba GET    /users/vba(.:format)                       users#vba
#         new_user_session GET    /users/sign_in(.:format)                   devise/sessions#new
#             user_session POST   /users/sign_in(.:format)                   devise/sessions#create
#     destroy_user_session DELETE /users/sign_out(.:format)                  devise/sessions#destroy
#            user_password POST   /users/password(.:format)                  devise/passwords#create
#        new_user_password GET    /users/password/new(.:format)              devise/passwords#new
#       edit_user_password GET    /users/password/edit(.:format)             devise/passwords#edit
#                          PATCH  /users/password(.:format)                  devise/passwords#update
#                          PUT    /users/password(.:format)                  devise/passwords#update
# cancel_user_registration GET    /users/cancel(.:format)                    devise/registrations#cancel
#        user_registration POST   /users(.:format)                           devise/registrations#create
#    new_user_registration GET    /users/sign_up(.:format)                   devise/registrations#new
#   edit_user_registration GET    /users/edit(.:format)                      devise/registrations#edit
#                          PATCH  /users(.:format)                           devise/registrations#update
#                          PUT    /users(.:format)                           devise/registrations#update
#                          DELETE /users(.:format)                           devise/registrations#destroy
#                     root GET    /                                          books#index
#             book_reviews GET    /books/:book_id/reviews(.:format)          reviews#index
#                          POST   /books/:book_id/reviews(.:format)          reviews#create
#          new_book_review GET    /books/:book_id/reviews/new(.:format)      reviews#new
#         edit_book_review GET    /books/:book_id/reviews/:id/edit(.:format) reviews#edit
#              book_review GET    /books/:book_id/reviews/:id(.:format)      reviews#show
#                          PATCH  /books/:book_id/reviews/:id(.:format)      reviews#update
#                          PUT    /books/:book_id/reviews/:id(.:format)      reviews#update
#                          DELETE /books/:book_id/reviews/:id(.:format)      reviews#destroy
#                    books GET    /books(.:format)                           books#index
#                          POST   /books(.:format)                           books#create
#                 new_book GET    /books/new(.:format)                       books#new
#                edit_book GET    /books/:id/edit(.:format)                  books#edit
#                     book GET    /books/:id(.:format)                       books#show
#                          PATCH  /books/:id(.:format)                       books#update
#                          PUT    /books/:id(.:format)                       books#update
#                          DELETE /books/:id(.:format)                       books#destroy
#

Rails.application.routes.draw do
  # get 'user/info', to:'user#info'
  get 'user/:id' => 'users#registered_user', as: :user
  match 'user/:id' => 'users#destroy', :via => :delete, :as => :destroy_user

  get 'admin_user/:id' => 'users#admin_user', as: :admin
  get 'moderator_user/:id' => 'users#moderator_user', as: :moderator
  get 'users' => 'users#all_users', as: :users

  get 'users/vba' => 'users#vba'
	devise_for :users

	root 'books#index'
  
	resources :books do
		resources :reviews
	end

end
