class CategoryAverageRatingByUser < ApplicationRecord
	validates :user_id, :category_id, presence: true

	def total_rating
		average_rating * number_of_reviews
	end

	def self.add_first_Category_Average_Rating(current_user_id = 1, book_category_id = 1, review_rating = 0)
		# puts "add_first_Category_Average_Rating " 
		CategoryAverageRatingByUser.create(user_id: current_user_id, category_id: book_category_id, average_rating: review_rating, number_of_reviews: 1)
	end

	def self.add_new_category_average_rating(current_user_id = 1, book_category_id = 1, new_review_rating = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
		number_of_reviews = result_tuple.number_of_reviews
		new_average = (result_tuple.average_rating * number_of_reviews + new_review_rating) / (number_of_reviews + 1)
		result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews+1 )
	end

end
