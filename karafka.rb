# frozen_string_literal: true

# Ruby on Rails setup
# Remove whole non-Rails setup that is above and uncomment the 4 lines below
ENV['RAILS_ENV'] ||= 'development'
ENV['KARAFKA_ENV'] = ENV['RAILS_ENV']
require ::File.expand_path('../config/environment', __FILE__)
Rails.application.eager_load!


class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka.seed_brokers = [ENV['KAFKA_HOST'] || 'kafka://localhost:9092']
    config.client_id = 'karafka_on_rails'
    config.backend = :inline
    config.batch_fetching = true
    # config.logger = Rails.logger
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::Listener)

  # Karafka.monitor.subscribe(WaterDrop::Instrumentation::StdoutListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::StdoutListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  consumer_groups.draw do
    consumer_group :heartbeats do
      topic :heartbeats do
        consumer ::HeartbeatConsumer
        parser AvroParser.new('heartbeat')
      end
    end
  end
end

KarafkaApp.boot!
