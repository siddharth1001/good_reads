# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role_id                :integer
#

class User < ApplicationRecord
  require_dependency 'user/constants'
  require_dependency 'user/callbacks'


	has_many :books, dependent: :destroy
	has_many :reviews, dependent: :destroy
	belongs_to :role

	validates_uniqueness_of :email
	validates :name, presence: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # USER_ROLES = {:registered=> 1,:banned=> 2,:moderator=> 3,:admin=> 4}
  Role_id_to_name = Hash[*ROLES.map{ |i| [i[1], i[0]] }.flatten]
  Role_name_to_id = Hash[*ROLES.map{ |i| [i[0], i[1]] }.flatten]

  def user_role
  	Role_id_to_name[self.role_id]
  end

  def send_notifcations
    UserMailer.welcome_email(self).deliver_now
  end

  private
  def set_default_role
  	# self.role ||= Role.find_by_name('registered')
  	self.role ||= Role.find(Role_name_to_id[:registered])
  end



end
