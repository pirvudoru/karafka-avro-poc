# frozen_string_literal: true

namespace :waterdrop do
  desc 'Generates messages to Kafka server'
  task :send do
    key = AvroParser.new('heartbeatKey')
                    .generate(
                      'resourceType' => 'movie',
                      'resourceId' => '42',
                      'userId' => nil,
                      'deviceId' => SecureRandom.hex
                    )
    message = AvroParser.new('heartbeat')
                        .generate('position' => 13, 'newPosition' => 42)

    WaterDrop::SyncProducer.call(message, topic: 'heartbeats', key: key)
  end
end
