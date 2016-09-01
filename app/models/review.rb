class Review < ApplicationRecord
	belongs_to :user
	belongs_to :book
	# belongs_to :category

	validates :rating, :comment, presence: true
	validates :user_id, :uniqueness => { :scope => :book_id,
		:message => "Users may only write one review per product." }

	after_create_commit :call_to_category_avearage

	def call_to_category_avearage(current_user_id, book_category_id, review_rating)
		if first_entry_to_CategoryAverageRatingByUser?(current_user_id, book_category_id)
			CategoryAverageRatingByUser.add_first_Category_Average_Rating(current_user_id, book_category_id, review_rating )
		else
			CategoryAverageRatingByUser.add_new_category_average_rating(current_user_id, book_category_id, review_rating)
		end
	end


	def first_entry_to_CategoryAverageRatingByUser?(current_user_id, book_category_id)
		!CategoryAverageRatingByUser.exists?(user_id: current_user_id , category_id: book_category_id)
	end



	end
