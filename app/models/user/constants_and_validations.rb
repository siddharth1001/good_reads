class User < ApplicationRecord

ROLES =[
  	[:registered, 1],
  	[:banned, 2],	
  	[:moderator, 3],
  	[:admin, 4]
  ]


#user fields validations
	validates_uniqueness_of :email
	validates :name, presence: true


#user avatar validations
  has_attached_file :avatar, styles: { medium: "200x200>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  # validates_attachment_file_name :avatar, matches: [/png\z/, /jpe?g\z/]
  # validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
  # validates :avatar, attachment_presence: true

end