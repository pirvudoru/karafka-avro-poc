class HeartbeatsController < ApplicationController
  def create
    key = AvroParser.new('heartbeat').generate(
      'resourceType' => 'movie',
      'resourceId' => 10,
      'userId' => nil,
      'deviceId' => SecureRandom.hex
    )
    message = AvroParser.new('heartbeat')
                        .generate('position' => 13, 'newPosition' => 42)

    WaterDrop::AsyncProducer.call(message,
                                  topic: 'heartbeats',
                                  key: key)
  end
end
