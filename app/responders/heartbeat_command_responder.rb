class HeartbeatCommandResponder < ApplicationResponder
  topic :heartbeats

  def respond(data)
    respond_to :heartbeats, { received: data }
  end
end
