class User < ApplicationRecord

ROLES =[
  	[:registered, 1],
  	[:banned, 2],	
  	[:moderator, 3],
  	[:admin, 4]
  ]


#validations
	validates_uniqueness_of :email
	validates :name, presence: true

	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
  validates :avatar, attachment_presence: true

end