WaterDrop.setup do |config|
  config.deliver = !Rails.env.test?
  config.kafka.seed_brokers = [ENV['KAFKA_HOST'] || 'kafka://localhost:9092']
end
