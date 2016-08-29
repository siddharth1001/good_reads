class CategoryAverageRatingByUser < ApplicationRecord
	validates :user_id, :category_id, presence: true
end
