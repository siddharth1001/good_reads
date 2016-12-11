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

require 'test_helper'

class CategoryAverageRatingByUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
