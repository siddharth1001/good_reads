class User < ApplicationRecord
  before_validation :set_default_role
  after_create :send_notifcations



  def send_notifcations
  	logger.debug "in send_notifcations !!"

  	begin
	    # UserMailer.welcome_email(self).deliver_now
      #will use sidekiq for this
  	rescue Exception => e
  		p e
  	end
  end

end