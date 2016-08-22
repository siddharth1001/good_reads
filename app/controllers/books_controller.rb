class BooksController < ApplicationController

	before_action :find_book, only: [:show, :edit, :update, :destroy]

	def index
		@books = Book.all
	end

	def new
		@book = current_user.books.build
	end

	def create
		@book = current_user.books.build(book_params)

		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'new'
		end
	end

	def destroy
		@book.destroy
		# flash[:success] = "Book deleted"
		redirect_to root_path
	end


	private

	  def book_params
	  	params.require(:book).permit(:title, :description, :author)
	  end

	  def find_book
	  	@book = Book.find(params[:id])
	  end
end
