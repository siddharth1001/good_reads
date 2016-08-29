class ReviewsController < ApplicationController
	
	before_action :find_book
	before_action :find_review , only: [:edit, :update, :destroy]
	
	def new
		@reviews = Review.new
	end

	def create
		@review = Review.new(review_params)
		@review.book_id = @book.id
		current_user_id = current_user.id
		book_category_id = @book.category_id
		@review.user_id = current_user_id

		if @review.save
			if CategoryAverageRatingByUser.exists?(user_id: current_user_id , category_id: book_category_id)
				update_Category_Average_Rating(current_user_id, book_category_id, @review.rating)
			else
				initialize_Category_Average_Rating(current_user_id, book_category_id, @review.rating )
			end
			redirect_to book_path(@book)
		else
			flash.now[:warning] = "  Error list : " << @review.errors.full_messages.to_s
			render 'new'
		end
	end


	def edit
		
	end

	def update
		if @review.update(review_params)

			puts params[:book_id].to_s << " ,,,  " << params[:id]
			category_id = Book.find(params[:book_id]).category_id

			# if params[:book_id].nil?
			# 	puts "params[:book_id].nil? ------- "
			# elsif params[:id].nil?
			# 	puts "params[:id] is nil !!98902183 821"
			# end
			update_Category_Average_Rating(current_user.id , category_id, @review.rating)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@review.destroy
		redirect_to book_path(@book)
	end

	private

	def review_params
		params.require(:review).permit(:rating, :comment)
	end

	def find_book
		@book = Book.find(params[:book_id])
	end

	def find_review
		@review = Review.find(params[:id])
	end

	private

	def initialize_Category_Average_Rating(current_user_id = 1, book_category_id = 1, review_rating = 0)
		CategoryAverageRatingByUser.create(user_id: current_user_id, category_id: book_category_id, average_rating: review_rating, number_of_reviews: 1)
	end

	def update_Category_Average_Rating(current_user_id = 1, book_category_id = 1, review_rating = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
		puts result_tuple.to_s << "yyyyyyyyyyyyyyyy"
		number_of_reviews = result_tuple.number_of_reviews
		new_average = (result_tuple.average_rating * number_of_reviews + review_rating) / (number_of_reviews + 1)
		result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews+1)
	end


end
