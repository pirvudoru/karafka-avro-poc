require 'avro_turf'
require 'avro_turf/messaging'

class AvroParser
  def initialize(schema_subject, schema_version)
    @schema_subject = schema_subject
    @schema_version = schema_version
  end

  def parse(content)
    avro.decode(content)
  end

  def generate(content)
    p "Generating "
    p content

    avro.encode(content, subject: @schema_subject, version: @schema_version)
  end

  def avro
    @avro ||= AvroTurf::Messaging.new(
      namespace: 'com.heartmonitor',
      registry_url: 'http://localhost:8081'
    )
  end
end


AvroTurf::ConfluentSchemaRegistry