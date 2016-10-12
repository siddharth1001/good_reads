class Category < ApplicationRecord
	has_many :books
	has_many :reviews, dependent: :destroy
end
