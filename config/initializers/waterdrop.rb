WaterDrop.setup do |config|
  config.deliver = !Rails.env.test?
  config.kafka.seed_brokers = [ENV['KAFKA_HOST'] || 'kafka://localhost:9092']
  config.kafka.delivery_threshold = 1_000
  config.kafka.max_queue_size = 1_000_000
end
