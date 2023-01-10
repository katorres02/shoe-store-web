import '../channels'
import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import ShoeEventsChannel from '../channels/shoe_events_channel'

const EventsBoard = () => {
  const [events, setEvents] = useState({})

  useEffect(() => { 
    ShoeEventsChannel.received = (newEvent) => {
      let updatedEvent = {}
      updatedEvent[newEvent.id] = newEvent
      setEvents(events => ({
        ...events,
        ...updatedEvent
      }));
    }
  })

  return (
    <div>
      <table>
        <thead>
          <tr>
            <th>Company</th>
            <th>Shoe Model</th>
            <th>Inventory Left</th>
            <th>Inventory Alert</th>
          </tr>
        </thead>
        <tbody>
        {Object.keys(events).map((key, index) => (
          <tr key={key}>
            <td>{events[key].store.name}</td>
            <td>{events[key].shoe.model}</td>
            <td>{events[key].shoe.inventory}</td>
            <td style={{ backgroundColor: events[key].shoe.alert}} ></td>
          </tr>
        ))}
        </tbody>
      </table>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <EventsBoard />,
    document.getElementById('app'))
})
