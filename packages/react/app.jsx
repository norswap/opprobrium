import React, { useState} from 'react'
import ReactDOM from 'react-dom/client'

import './www/style.css'

const ALCHEMY_ID='_Kk7f1qWnBq1aRfgSMjfaDLTBl9ubL0a'

// =============================================================================
// Configure Rainbow

import '@rainbow-me/rainbowkit/styles.css'
import { ConnectButton } from '@rainbow-me/rainbowkit';

import {
  getDefaultWallets,
  RainbowKitProvider,
  darkTheme,
} from '@rainbow-me/rainbowkit'

import {
  chain,
  configureChains,
  createClient,
  WagmiConfig,
} from 'wagmi'

// import { alchemyProvider } from 'wagmi/providers/alchemy'
import { publicProvider } from 'wagmi/providers/public'

const { chains, provider } = configureChains(
    [chain.goerli],
//  [chain.optimismGoerli],
  [
//    alchemyProvider({ apiKey: ALCHEMY_ID }),
    publicProvider()
  ]
)

const { connectors } = getDefaultWallets({
  appName: 'Opprobrium',
  chains
})

const wagmiClient = createClient({
  autoConnect: true,
  connectors,
  provider
})

// =============================================================================

const buildings = require('../data/buildings/buildings.json')

function Building(props) {
  const [level, setLevel] = useState(0);

  const upgradeBuilding = () => {
    setLevel(level + 1)
  }

  const keyName = props.name.toLowerCase().replaceAll(' ', '_')
  const lvl = buildings[keyName][level]
  const nextLvl = buildings[keyName][level + 1]

  const upgradeInfo = !nextLvl ? <></>
    : <>
      <p>Next level: +{nextLvl.productionRate - lvl.productionRate} units/seconds<br/>
        Upgrade Cost: {nextLvl.costMineral} 💠 {nextLvl.costGas} ☣ ️{nextLvl.costDeuterium} 🧪<br/>
        Upgrade Time: {nextLvl.constructionTime}</p>
      <button type="button" className="btn btn-dark btn-sm"
              onClick={upgradeBuilding}>
        Upgrade
      </button>
    </>

  return <div className="row building border my-3">
    <img className="col-md-3 px-0" src={props.url}  alt="building illustration"/>
    <div className="col-md-9 px-3 py-3">
      <h4>{props.name}</h4>
      <p>Level: {level}<br/>
        Production: {lvl.productionRate} units/seconds</p>
      {upgradeInfo}
    </div>
  </div>
}

function AppBody() {
  return <div className="container-lg text-light">
    <div className="rainbowkit">
      <ConnectButton showBalance={false} />
    </div>
    <h1 className="mx-5 my-3 display-1"><em>OPPROBRIUM</em> 💥✨</h1>
    <Building name="Mineral Mine" url="assets/mineral-mine.png" />
    <Building name="Gas Extractor" url="assets/gas-extractor.png" />
    <Building name="Deuterium Synthesizer" url="assets/deuterium-synthesizer.png" />
  </div>
}

function App() {
  return <React.StrictMode>
    <WagmiConfig client={wagmiClient}>
    <RainbowKitProvider chains={chains} theme={darkTheme()}>
      <AppBody />
  </RainbowKitProvider>
  </WagmiConfig>
  </React.StrictMode>
}

const root = ReactDOM.createRoot(document.getElementById('root'))
root.render(<App />)
