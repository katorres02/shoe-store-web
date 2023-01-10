import consumer from "./consumer"

const ShoeEventsChannel = consumer.subscriptions.create("ShoeEventsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("connected to ShoeEventsChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("disconnected from ShoeEventsChannel")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
})

export default ShoeEventsChannel
