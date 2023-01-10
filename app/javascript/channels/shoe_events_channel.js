import consumer from "channels/consumer"

consumer.subscriptions.create("ShoeEventsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected to ShoeEventsChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected from ShoeEventsChannel")
  },

  received(data) {
    console.log(data)
    // Called when there's incoming data on the websocket for this channel
  }
});
