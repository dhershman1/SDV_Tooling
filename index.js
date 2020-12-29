const path = require('path')
const express = require('express')
const app = express()

app.use(express.static(path.join(__dirname, 'public')))

app.get('*', (_, res) => {
  return res.sendFile('index.html', { root: path.join(__dirname, 'public') })
})

app.listen(3000, () => {
  console.log('App listening on port 3000')
})
