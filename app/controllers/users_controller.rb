class UsersController < ApplicationController

  before_action :all_books, only: [:registered_user, :admin_user, :moderator_user, :apps]
  before_action :all_users, only: [:admin_user, :moderator_user, :apps]

  def all_users
    if user_signed_in?
      @users = User.all.paginate(page: params[:page], :per_page => 10)
    else
      redirect_to root_url, notice: "Please sign in."
    end
  end

  def registered_user
  	if user_signed_in?
  		@books_user_added = @books.where(user_id: current_user.id).paginate(page: params[:page], :per_page => 4)  #USE scope Here
      @sample_books = Book.all.paginate(:page => params[:page])
    else
      redirect_to root_url, notice: "Please sign in."
    end
  end

  def admin_user
    if user_signed_in?
      #do something
    else
      redirect_to root_url, notice: "Please sign in."
    end
  end

  def moderator_user
      redirect_to root_url, notice: "Please sign in." if !user_signed_in?
  end

  def destroy
    @user = User.find(params[:id])
    name = @user.name
    @user.destroy

    if @user.destroy
      redirect_to root_url, notice: "Dear #{name}, it's bad to see you go."
    end
  end

def apps

  # render application_url
end
  

  private
  
  def all_books
    @books = Book.all
  end

  def all_users
    @users = User.all.paginate(page: params[:page], :per_page => 10)
  end
end
