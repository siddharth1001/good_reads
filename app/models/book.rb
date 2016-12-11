# == Schema Information
#
# Table name: books
#
#  id                    :integer          not null, primary key
#  title                 :string
#  description           :text
#  author                :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  user_id               :integer
#  category_id           :integer
#  book_img_file_name    :string
#  book_img_content_type :string
#  book_img_file_size    :integer
#  book_img_updated_at   :datetime
#

class Book < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews, dependent: :destroy

	validates :title, :description, :author, :category_id, :book_img, presence: true

	has_attached_file :book_img, styles: { small: "100x120>" , medium: "250x500>", thumb: "320x475>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

	scope :desc_order, -> {order("created_at DESC")}

	def self.search(search_book)
		where("title LIKE ?", "%#{search_book}%")
	end

	def self.average_rating_by_user(current_user_id, category_id )
		result_tuple = CategoryAverageRatingByUser.find_by(user_id: current_user_id, category_id: category_id)
		return 0 if result_tuple.nil?
		result_tuple.average_rating
	end
	
end
