class User < ApplicationRecord
  after_create :send_notifcations
end