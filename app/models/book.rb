class Book < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews, dependent: :destroy


	validates :title, :description, :author, :category_id, :book_img, presence: true

	has_attached_file :book_img, styles: { medium: "250x500>", thumb: "320x475>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :book_img, content_type: /\Aimage\/.*\z/

	def self.search(search)
		where("title LIKE ?", "%#{search}%")
	end
end
