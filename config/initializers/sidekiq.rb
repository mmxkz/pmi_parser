require "sidekiq"
require "sidekiq/web"

sidekiq_config = { url: ENV['REDIS_HOST_SIDEKIQ'] }

Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
