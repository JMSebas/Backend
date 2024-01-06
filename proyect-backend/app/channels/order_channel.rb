class OrderChannel < ApplicationCable::Channel
  def subscribed
    stream_from "OrderChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
