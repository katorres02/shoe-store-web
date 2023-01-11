import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import EventsBoard from './events_board'
import SuggestionsBoard from './suggestions_board'

const App = () => {
  return (
    <div style={{display: "inline-flex"}}>
      <EventsBoard></EventsBoard>
      <SuggestionsBoard></SuggestionsBoard>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.getElementById('app'))
})
