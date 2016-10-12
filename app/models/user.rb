class User < ApplicationRecord
	has_many :books, dependent: :destroy
	has_many :reviews, dependent: :destroy
	belongs_to :role

	before_validation :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  private
  def set_default_role
  	self.role ||= Role.find_by_name('registered')
  end

end
