class User < ApplicationRecord
  before_validation :set_default_role
  after_create :send_notifcations
end