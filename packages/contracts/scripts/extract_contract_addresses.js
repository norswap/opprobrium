const fs = require('fs')
const output = {}

const lineReader = require('readline').createInterface({
  input: fs.createReadStream(process.argv[2])
});

lineReader.on('line', line => {
  const [label, _, address] = line.trim().split(" ")
  output[label] = address
})

lineReader.on('close', () => {
  console.log(JSON.stringify(output, null, 4))
})
