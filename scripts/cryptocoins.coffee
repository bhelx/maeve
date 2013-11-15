# Description:
# Find the latest cryptocurrency prices
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# maeve btc [usd] - bitcoin command, fiat currency optional, defaults to usd
# maeve ltc [usd] - litecoin command, fiat currency optional, defaults to usd
# maeve coins [crypto] [usd] - generic command, must supply first arg, second defaults to usd but could also be another crypto
#
# Author:
# bhelx

module.exports = (robot) ->
  robot.respond /(btc|ltc) ?(.*)/i, (msg) ->
    coinPrice msg
  robot.respond /coins ?([a-zA-Z]*) ?([a-zA-Z]*)/i, (msg) ->
    coinPrice msg

symbols =
  usd: '$'
  eur: '€'

coinPrice = (msg, crypto, fiat) ->
  crypto = msg.match[1]
  fiat = (msg.match[2] || 'usd').trim().toLowerCase()

  msg
    .send "Fetching..."
  msg
    .http("http://data.mtgox.com/api/1/#{crypto}#{fiat}/ticker")
    .get() (err, res, body) ->
      tick = JSON.parse(body)
      if err or tick.result != 'success'
        return msg.send "Sorry btc-e doesn't like that combination"

      #symbol = symbols[fiat] || ''
      msg.send "#{crypto.toUpperCase()}: #{tick.return.last.display} (H: #{tick.return.high.display} | L: #{tick.return.low.display})"

