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
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#

class User < ApplicationRecord
  require_dependency 'user/constants_and_validations'
  require_dependency 'user/callbacks'


	has_many :books, dependent: :destroy
	has_many :reviews, dependent: :destroy
	belongs_to :role

  before_validation :set_default_role
  after_create :send_notifcations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  # validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  # validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]
  
  # USER_ROLES = {:registered=> 1,:banned=> 2,:moderator=> 3,:admin=> 4}
  Role_id_to_name = Hash[*ROLES.map{ |i| [i[1], i[0]] }.flatten]
  Role_name_to_id = Hash[*ROLES.map{ |i| [i[0], i[1]] }.flatten]

  def user_role
  	Role_id_to_name[self.role_id]
  end

  private
  def set_default_role
  	# self.role ||= Role.find_by_name('registered')
  	self.role ||= Role.find(Role_name_to_id[:registered])
  end
  
end
