require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RndsWebSniffer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.eager_load_paths << Rails.root.join('app/services')
    config.autoload_paths   << Rails.root.join('app/services')
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths   << Rails.root.join('lib')

    # Delayed Jobs
    config.active_job.queue_adapter = :sidekiq
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = [:ru]

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
