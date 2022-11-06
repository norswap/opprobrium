const { build } = require('esbuild')
const dotenv = require('dotenv')
const fs = require('fs')

const NODE_ENV = process.env.NODE_ENV
const known_envs = ['prod', 'dev']
const watch = process.argv.includes('--watch')

if (!known_envs.includes(NODE_ENV)) {
    console.log(`NODE_ENV set to ${NODE_ENV}`)
    console.log(`must define NODE_ENV to one of: ${known_envs}`)
    process.exit(1)
}

const options = {
  entryPoints: ['./app.jsx'],
  outdir: './www/',
  bundle: true,
  minify: NODE_ENV === 'prod',
  watch: watch,
  define: {
    'process.env.NODE_ENV': JSON.stringify(NODE_ENV)
  },
}

const env = dotenv.parse(fs.readFileSync(NODE_ENV + ".env"))

for (const k in env) {
  options.define[`process.env.${k}`] = JSON.stringify(env[k])
}

build(options).catch(() => process.exit(1))
