class Review < ApplicationRecord
	belongs_to :user
	belongs_to :book

	validates :rating, :comment, presence: true
	validates :user_id, :uniqueness => { :scope => :book_id,
    :message => "Users may only write one review per product." }
end
