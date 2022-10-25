import * as React from 'react'
import ReactDOM from 'react-dom/client'

const ALCHEMY_ID='_Kk7f1qWnBq1aRfgSMjfaDLTBl9ubL0a'

// =============================================================================
// Configure Rainbow

import '@rainbow-me/rainbowkit/styles.css'
import { ConnectButton } from '@rainbow-me/rainbowkit';

import {
  getDefaultWallets,
  RainbowKitProvider,
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

class Building extends React.Component {

  constructor(props) {
    super(props);
    this.state = {level: 1};
  }

  upgradeBuilding = () => {
    this.setState({level: this.state.level + 1});
  };

  render() {
    return <div className="row building border my-3">
      <img className="col-md-3 px-0" src={this.props.url} />
      <div className="col-md-9 px-3 py-3">
        <h4>{this.props.name}</h4>
        <p>Level: {this.state.level}<br/>
        Production: 60 units/seconds<br/>
        Next level: +20 units/seconds<br/>
        Upgrade Cost: 30 🪨 30 💎 30 🧪<br/>
        Upgrade Time: 60 minutes</p>
        <button type="button" className="btn btn-dark btn-sm"
                onClick={this.upgradeBuilding}>
          Upgrade
        </button>
      </div>
    </div>
  }
}

function AppBody() {
  return <div className="container-lg text-light">
    <h1 className="mx-5 my-3 display-1"><em>OPPROBRIUM</em> 💥✨</h1>
    <ConnectButton />
    <Building name="Mineral Mine" url="assets/mineral-mine.png" />
    <Building name="Crystal Mine" url="assets/crystal-mine.png" />
    <Building name="Deuterium Synthesizer" url="assets/deuterium-synthesizer.png" />
  </div>
}

function App() {
  return <WagmiConfig client={wagmiClient}>
    <RainbowKitProvider chains={chains}>
      <AppBody />
    </RainbowKitProvider>
  </WagmiConfig>
}

const root = ReactDOM.createRoot(document.getElementById('root'))
root.render(<App />)
