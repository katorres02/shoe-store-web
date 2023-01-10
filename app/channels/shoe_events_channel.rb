class ShoeEventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "shoe_events_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
