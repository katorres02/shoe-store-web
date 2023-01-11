import consumer from "./consumer"

const SuggestionsReportChannel = consumer.subscriptions.create("SuggestionsReportChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected to SuggestionsReportChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected from SuggestionsReportChannel")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("SuggestionsReportChannel: ", data)
  }
});
export default SuggestionsReportChannel