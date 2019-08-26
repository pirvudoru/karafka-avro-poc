class HeartbeatCommandConsumer < ApplicationConsumer
  def consume
    p 'received: '
    pp params_batch.parsed

    respond_with 42
  end
end
