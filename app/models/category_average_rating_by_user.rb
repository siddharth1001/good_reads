# == Schema Information
#
# Table name: category_average_rating_by_users
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  category_id       :integer
#  average_rating    :float
#  number_of_reviews :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class CategoryAverageRatingByUser < ApplicationRecord
	validates :user_id, :category_id, presence: true
	validates_uniqueness_of :user_id, :scope => :category_id


	def self.add_first_Category_Average_Rating(current_user_id = 1, category_id = 1, review_rating = 0)
		puts "add_first_Category_Average_Rating !!!!!!!!!" 
		CategoryAverageRatingByUser.create(user_id: current_user_id, category_id: category_id, average_rating: review_rating, number_of_reviews: 1)
	end

	def self.add_new_category_average_rating(current_user_id = 1, category_id = 1, new_review_rating = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: category_id)
		number_of_reviews = result_tuple.number_of_reviews
		new_average = (result_tuple.average_rating * number_of_reviews + new_review_rating).to_f / (number_of_reviews + 1)
		result_tuple.update_attributes(user_id: current_user_id, category_id: category_id, average_rating: new_average , number_of_reviews: number_of_reviews+1 )
	end

	def self.update_category_average_rating(current_user_id = 1, book_category_id = 1, review_rating_diff = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
		number_of_reviews = result_tuple.number_of_reviews
		new_average = (result_tuple.average_rating * number_of_reviews + review_rating_diff) / (number_of_reviews )
		result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews)
	end

	def self.update_category_average_rating_after_deletion(current_user_id = 1, book_category_id = 1, deleted_rating = 0)
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: book_category_id)
		number_of_reviews = result_tuple.number_of_reviews
		if number_of_reviews == 1
			new_average = 0
		else
			new_average = (result_tuple.average_rating * number_of_reviews - deleted_rating) / (number_of_reviews-1)
		end
		result_tuple.update_attributes(user_id: current_user_id, category_id: book_category_id, average_rating: new_average , number_of_reviews: number_of_reviews-1)
	end

end
