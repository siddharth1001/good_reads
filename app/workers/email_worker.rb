class EmailWorker
  include Sidekiq::Worker

# require 'sidekiq'
# require 'sidekiq/testng/inline'

  sidekiq_options retry: false

  def perform(user_id)
    # do something
   binding.pry
    user = User.find_by_id(user_id)
    UserMailer.welcome_email(user).deliver_now
  end
end
