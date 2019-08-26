# frozen_string_literal: true

namespace :waterdrop do
  desc 'Generates messages to Kafka server'
  task :send do
    message = AvroParser.new('heartbeatCommandValue', '1')
                        .generate(
                          'name' => 'somename',
                          'number1' => 42,
                          'number2' => 4.2
                        )
    key = AvroParser.new('heartbeatCommandKey', '1')
                    .generate('resourceType' => 'movie',
                              'resourceId' => '1234',
                              'userId' => '42')

    WaterDrop::SyncProducer.call(message, topic: 'heartbeat_commands', key: key)
  end
end
