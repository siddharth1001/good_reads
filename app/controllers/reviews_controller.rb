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

		puts book_category_id.to_s << " --=-== - == = =" << current_user_id.to_s


		if @review.save
			# if CategoryAverageRatingByUser.exists?(user_id: current_user_id , category_id: book_category_id)
			# 	add_new_category_average_rating(current_user_id, book_category_id, @review.rating)
			# else
			# 	add_first_Category_Average_Rating(current_user_id, book_category_id, @review.rating )
			# end
			puts "call_to_category_avearagecall_to_category_avearagecall_to_category_avearage"
			# @review.call_to_category_avearage(current_user_id, book_category_id, @review.rating)
			redirect_to book_path(@book)
		else
			flash.now[:warning] = "  Error list : " << @review.errors.full_messages.to_s
			render 'new'
		end
	end


	def edit
		# @original_rating = @review.rating
		# puts @original_rating.to_s << " === - -= --= -=- - =- -= - = -= -=- - =- =- = -=- ="
	end

	def update
		@original_rating = @review.rating
		if @review.update(review_params)

			# puts params[:book_id].to_s << " ,,,  " <<   "@review.rating - " << @review.rating.to_s << "  original_rating - " << @original_rating.to_s
			category_id = @book.category_id
			update_category_average_rating(current_user.id , category_id, @review.rating - @original_rating)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@original_rating = @review.rating
		category_id = @book.category_id

		@review.destroy
		update_category_average_rating_after_deletion(current_user.id , category_id, - @original_rating)
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


	# def add_first_Category_Average_Rating(current_user_id = 1, book_category_id = 1, review_rating = 0)
	# 	# puts "add_first_Category_Average_Rating " 
	# 	CategoryAverageRatingByUser.create(user_id: current_user_id, category_id: book_category_id, average_rating: review_rating, number_of_reviews: 1)
	# end

	# def add_new_category_average_rating(current_user_id = 1, book_category_id = 1, new_review_rating = 0)
	# 	result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
	# 	number_of_reviews = result_tuple.number_of_reviews
	# 	new_average = (result_tuple.average_rating * number_of_reviews + new_review_rating) / (number_of_reviews + 1)
	# 	result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews+1 )
	# end

	def update_category_average_rating(current_user_id = 1, book_category_id = 1, review_rating_diff = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
		number_of_reviews = result_tuple.number_of_reviews
		new_average = (result_tuple.average_rating * number_of_reviews + review_rating_diff) / (number_of_reviews )
		result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews)
	end

	def update_category_average_rating_after_deletion(current_user_id = 1, book_category_id = 1, review_rating_diff = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
		number_of_reviews = result_tuple.number_of_reviews
		new_average = (result_tuple.average_rating * number_of_reviews + review_rating_diff) / (number_of_reviews-1)
		result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews-1)
	end

end
