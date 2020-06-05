SIDEKIQ_STATUS_EXPIRATION = 10.minute
REDIS_HOST = ENV['REDIS_URL'] || 'redis://localhost'

Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_HOST }

end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_HOST }

end


# © Rnd-Soft (Рнд Софт), 2017-2020
