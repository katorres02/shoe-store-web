class SuggestionsReportChannel < ApplicationCable::Channel
  def subscribed
    stream_from "suggestions_report_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
