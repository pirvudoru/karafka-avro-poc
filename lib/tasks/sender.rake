# frozen_string_literal: true

namespace :waterdrop do
  desc 'Generates messages to Kafka server'
  task :send do
    1_000_000.times.each do |i|
      key = AvroParser.new('heartbeat').generate(
        'resourceType' => 'movie',
        'resourceId' => i.to_s,
        'userId' => nil,
        'deviceId' => SecureRandom.hex
      )
      message = AvroParser.new('heartbeat')
                          .generate('position' => 13, 'newPosition' => 42)

      WaterDrop::AsyncProducer.call(message,
                                    topic: 'heartbeats',
                                    key: key)
    end

    p 'done'
  end
end
