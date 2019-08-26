class HeartbeatConsumer < ApplicationConsumer
  def consume
    p 'received: '
    pp params_batch.parsed
  end
end
