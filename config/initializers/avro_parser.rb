require 'avro_turf'
require 'avro_turf/messaging'

class AvroParser
  def initialize(schema_name)
    @schema_name = schema_name
  end

  def parse(content)
    self.class.avro.decode(content)
  end

  def generate(content)
    self.class.avro.encode(content, schema_name: @schema_name)
  end

  class << self
    def avro
      @avro ||= AvroTurf::Messaging.new(
        schemas_path: 'app/schemas/',
        namespace: 'com.heartmonitor',
        registry_url: 'http://localhost:8081'
      )
    end
  end
end
