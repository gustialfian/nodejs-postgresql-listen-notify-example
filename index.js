const { Client } = require('pg')

const client = new Client({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: 'postgres',
  port: 5432,
})

client.connect()

client.query('SELECT NOW()', (err, res) => {
  console.log('db up... ')
})

client.query('LISTEN new_item')

client.on('notification', msg => {
  console.log(msg.channel) // foo
  console.log(msg.payload) // bar!
})
