import * as React from 'react'
import ReactDOM from 'react-dom'

function Building(props) {
    return <div class="row building border my-3">
        <img class="col-md-3 px-0" src={props.url} />
        <div class="col-md-9 px-3 py-3">
          <h4>{props.name}</h4>
          <p>Level: 1<br/>
          Production: 60 units/seconds<br/>
          Next level: +20 units/seconds<br/>
          Upgrade Cost: 30 🪨 30 💎 30 🧪<br/>
          Upgrade Time: 60 minutes</p>
        </div>
      </div>
}

function App() {
    return <div class="container-lg text-light">
      <h1 class="mx-5 my-3 display-1"><em>OPPROBRIUM</em> 💥✨</h1>
      <Building name="Mineral Mine" url="assets/mineral-mine.png" />
      <Building name="Crystal Mine" url="assets/crystal-mine.png" />
      <Building name="Deuterium Synthesizer" url="assets/deuterium-synthesizer.png" />
    </div>
}

ReactDOM.render(<App />, document.querySelector('#root'))
