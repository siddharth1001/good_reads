class UsersController < ApplicationController
  def info
  	if user_signed_in?
  		current_user.email
  		@books = Book.all
  		@books_user_added = @books.where(user_id: current_user.id)  #USE scope Here
    else
      redirect_to root_url, notice: "Please sign in."
  	end

  end

  def destroy
  	puts "====================== = = == = == "
    @user = User.find(params[:id])
    name = @user.name
    @user.destroy

    if @user.destroy
        redirect_to root_url, notice: "Dear #{name}, it's bad to see you go."
    end
  end
end
