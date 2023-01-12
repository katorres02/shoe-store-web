import '../channels'
import React, { useState, useEffect } from 'react'
import ShoeEventsChannel from '../channels/shoe_events_channel'

const EventsBoard = () => {
  const [events, setEvents] = useState({})

  useEffect(() => { 
    ShoeEventsChannel.received = (newEvent) => {
      let updatedEvent = {}
      updatedEvent[newEvent.customId] = newEvent
      setEvents(events => ({
        ...events,
        ...updatedEvent
      }));
    }
  })

  return (
    <div style={{float: "left", width: '600px'}}>
      <h2>REALTIME SALES</h2>
      <table style={{marginTop: '45px'}}>
        <thead>
          <tr>
            <th><u>Company</u></th>
            <th><u>Shoe Model</u></th>
            <th><u>Inventory Left</u></th>
            <th><u>Inventory Alert</u></th>
          </tr>
        </thead>
        <tbody>
        {Object.keys(events).map((key) => (
          <tr key={key}>
            <td>{events[key].store.name}</td>
            <td>{events[key].model}</td>
            <td>{events[key].inventory}</td>
            <td style={{ backgroundColor: events[key].alert}} ></td>
          </tr>
        ))}
        </tbody>
      </table>
    </div>
    
  )
}

export default EventsBoard
