// This script take "buildings.json" and uses it to render the BuildingsData.sol smart contract.

import { createRequire } from 'module'
import { promisify } from 'util'
import ejs from 'ejs'
import fs from 'fs'

const renderFile = promisify(ejs.renderFile)

const require = createRequire(import.meta.url)
const buildings = require('./buildings.json')

// could also use this but creates an experimental warning:
// import buildings from "./buildings.json" assert {type: 'json'}

const rendered = await renderFile('./BuildingsData.sol.ejs', buildings)

// write in packages/contracts/src/Buildings.sol
fs.writeFileSync('../../contracts/src/BuildingsData.sol', rendered)
