import React, { useState, useEffect } from 'react'
import ReactDOM from 'react-dom'
import EventsBoard from './events_board'
import SuggestionsBoard from './suggestions_board'
import { ApolloClient, InMemoryCache, ApolloProvider, gql } from '@apollo/client';

const App = () => {
  return (
    <div style={{display: "inline-flex"}}>
      <EventsBoard></EventsBoard>
      <SuggestionsBoard></SuggestionsBoard>
    </div>
  )
}

const client = new ApolloClient({
    uri: 'http://localhost:3000/graphql',
    cache: new InMemoryCache(),
});

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <ApolloProvider client={client}>
        <App />
    </ApolloProvider>,
    document.getElementById('app'))
})
