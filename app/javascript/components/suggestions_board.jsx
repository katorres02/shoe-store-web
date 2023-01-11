import '../channels'
import React, { useState, useEffect } from 'react'
import SuggestionsReportChannel from '../channels/suggestions_report_channel'

const SuggestionsBoard = () => {
  const [suggestions, setSuggestions] = useState([])

  useEffect(() => { 
    SuggestionsReportChannel.received = (report) => {
        setSuggestions(report);
    }
  })

  return (
    <div style={{float: "left", width: '900px', marginLeft: '100px'}}>
      <h2>SUGGEESTED SHOE TRANSFERS</h2>
      <table >
        <thead>
          <tr>
            <th colSpan={4} style={{textAlign: 'center'}} >Stores getting out of shoes</th>
            <th colSpan={4} style={{textAlign: 'center'}}>Stores with big supply of shoes</th>
          </tr>
          <tr>
            <th><u>Company</u></th>
            <th><u>Shoe Model</u></th>
            <th><u>Inventory</u></th>
            <th><u>Alert</u></th>

            <th><u>Company</u></th>
            <th><u>Shoe Model</u></th>
            <th><u>Inventory</u></th>
            <th><u>Alert</u></th>
          </tr>
        </thead>
        <tbody>
        {suggestions.map((val) => (
          <tr key={val.id}>
            <td>{val.low.store.name}</td>
            <td>{val.low.shoe.model}</td>
            <td>{val.low.shoe.inventory}</td>
            <td style={{ backgroundColor: val.low.shoe.alert}} ></td>

            <td>{val.high.store.name}</td>
            <td>{val.high.shoe.model}</td>
            <td>{val.high.shoe.inventory}</td>
            <td style={{ backgroundColor: val.high.shoe.alert}} ></td>
          </tr>
        ))}
        </tbody>
      </table>
    </div>
  )
}

export default SuggestionsBoard
