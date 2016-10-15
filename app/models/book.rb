class Book < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews, dependent: :destroy

	validates :title, :description, :author, :category_id, :book_img, presence: true

	has_attached_file :book_img, styles: { medium: "250x500>", thumb: "320x475>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/


	def self.search(search_book)
		where("title LIKE ?", "%#{search_book}%")
	end

	def self.average_rating_by_user(current_user_id, category_id )
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: category_id)
		return 0 if result_tuple.nil?
		result_tuple.average_rating
	end
end
