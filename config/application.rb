require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GoodReads
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
config.autoload_paths += %W(#{config.root}/lib)
config.autoload_paths += Dir["#{config.root}/lib/**/"]
config.autoload_paths += %W(#{config.root}/app/workers)

config.eager_load_paths += ["#{config.root}/lib"]
config.eager_load_paths += ["#{config.root}/lib/**/"]
config.eager_load_paths += %W(#{config.root}/app/workers)

    # config.logger = Logger.new(STDOUT)
  end
end
