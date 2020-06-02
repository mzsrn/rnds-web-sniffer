class BobikChannel < ApplicationCable::Channel
  def subscribed
    stream_from "bobik:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
