class Review < ApplicationRecord
	belongs_to :user
	belongs_to :book
	belongs_to :category

	validates :rating, :comment, presence: true
	validates :user_id, :uniqueness => { :scope => :book_id,
		:message => "Users may only write one review per book." }

	after_create_commit :set_category_average_on_review_creation
	after_update_commit :update_category_average_on_review_updation
	before_destroy :get_original_review_rating_berfore_destroy
	after_destroy_commit :update_category_average_on_review_deletion

	def set_category_average_on_review_creation

		if entry_for_CategoryAverageRatingByUser?(user_id , category_id)
			CategoryAverageRatingByUser.add_new_category_average_rating(user_id, category_id, rating)
		else
			CategoryAverageRatingByUser.add_first_Category_Average_Rating(user_id, category_id, rating)
		end
	end

	def update_category_average_on_review_updation
		original_rating = rating_previous_change[-2]
		CategoryAverageRatingByUser.update_category_average_rating(user_id , category_id, rating - original_rating)
	end

	def entry_for_CategoryAverageRatingByUser?(user_id , category_id)
		CategoryAverageRatingByUser.exists?(user_id: user_id , category_id: category_id)
	end

	def update_category_average_on_review_deletion
		CategoryAverageRatingByUser.update_category_average_rating_after_deletion(user_id , category_id, - @original_rating)
	end

	def get_original_review_rating_berfore_destroy
		@original_rating = rating
		puts "original_rating = #{@original_rating}======== rating = #{rating} =--=-=-=-=-= user_id = #{user_id} =-=-=-=-=-=--=BEFORE destroy-=-==--0=0-=0-=0-=0-=AAAA"
	end
	

end
