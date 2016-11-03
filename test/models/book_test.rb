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

require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
