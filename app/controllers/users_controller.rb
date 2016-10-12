class UsersController < ApplicationController
  def info
  	if user_signed_in?
  		current_user.email
  		@books = Book.all
  		@books_user_added = @books.where(user_id: current_user.id)
  	end
  end

  def destroy
  	puts "====================== = = == = == "
    @user = User.find(params[:id])
    @user.destroy

    if @user.destroy
        redirect_to root_url, notice: "User deleted."
    end
  end
end
