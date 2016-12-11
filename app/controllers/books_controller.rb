class BooksController < ApplicationController

	before_action :find_book, only: [:show, :edit, :update, :destroy]
	# before_action :average_review_for_category, only: [:index]

	def index
		if params[:category].blank? && params[:search].blank?
			# @books = Book.all.order("created_at DESC")
			@books = Book.all.desc_order.paginate(page: params[:page], :per_page => 12)
		elsif !params[:search].blank?
			@books = Book.search(params[:search]).paginate(page: params[:page], :per_page => 12)
		else
			@category_id = Category.find_by(name: params[:category]).id
			@books = Book.where(category_id: @category_id).order("created_at DESC").paginate(page: params[:page], :per_page => 10)
			if user_signed_in?
				@average_rating = Book.average_rating_by_user(current_user.id, @category_id)
			end
			# average_review_for_category unless !user_signed_in?
		end
	end

	def new
		@book = current_user.books.build
		@categories = Category.all.map{ |c| [c.name, c.id] }
	end

	def create
		@book = current_user.books.build(book_params)
		if !params[:category_id].blank?
			@book.category_id = params[:category_id]
		end

		@categories = Category.all.map{ |c| [c.name, c.id] }
		if @book.save
			redirect_to root_path
		else
			# flash.now[:warning] = "*Please fill all the necessary details" << image_error
			flash.now[:warning] = "  Error list : " << @book.errors.full_messages.to_s
			render 'new'
		end
	end

	def show
		if @book.reviews.blank?
			@average_review = 0
		else
			@average_review = @book.reviews.average(:rating)
		end
	end

	def edit
		@categories = Category.all.map{ |c| [c.name, c.id] }
		# @average_review = @book.reviews.average(:rating)
	end

	def update
		@book.category_id = params[:category_id] 
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'new'
		end
	end

	def destroy
		@book.destroy
		flash[:success] = "Book deleted"
		redirect_to root_path
	end

	# def get_all_books
	# 	@books = Book.all.order("created_at DESC");
	# end

  def vba
    # render :json => {:abc => "json hai"}
    respond_to do |format|
    # @java_url = "/home/ajax_download?file=#{file_name}"
      format.js  #{render :partial => "abc"}
    end

  end

	private

	def book_params
		params.require(:book).permit(:title, :description, :author, :category_id, :book_img)
	end

	def find_book
		@book = Book.find(params[:id])
	end

	
	# def average_review_for_category
	# 	count = 0;
	# 	@average_rating_in_category = 0
	# 	@books.each do |book|
	# 		reviews_by_user = book.reviews.where(user_id: current_user.id)
	# 		reviews_by_user.each do |review|
	# 			@average_rating_in_category += review.rating
	# 			count +=1
	# 		end
	# 	end
	# 	@average_rating_in_category /= count.to_f unless count == 0
	# end
end
