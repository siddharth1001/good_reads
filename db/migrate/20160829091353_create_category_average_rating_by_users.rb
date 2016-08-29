class CreateCategoryAverageRatingByUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :category_average_rating_by_users do |t|
      t.integer :user_id
      t.integer :category_id
      t.float :average_rating
      t.integer :number_of_reviews

      t.timestamps
    end
  end
end
