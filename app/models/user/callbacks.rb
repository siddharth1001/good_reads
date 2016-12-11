class User < ApplicationRecord
  before_validation :set_default_role
  after_create :send_notifcations


  def send_notifcations
  	logger.debug "in send_notifcations !!"

  	begin
      EmailWorker.perform_async(self.id)
  	rescue Exception => e
  		p e
      puts "===========$$$$$$$$==========="
  	end
  end

end