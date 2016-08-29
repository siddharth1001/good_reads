class UserController < ApplicationController
  def info
  	if user_signed_in?
  		current_user.email
  		@books = Book.all
  		@books_user_added = @books.where(user_id: current_user.id)
  	end
  end
end
