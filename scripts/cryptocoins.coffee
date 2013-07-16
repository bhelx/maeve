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
# hubot btc [usd] - bitcoin command, fiat currency optional, defaults to usd
# hubot ltc [usd] - litecoin command, fiat currency optional, defaults to usd
#
# Author:
# bhelx

module.exports = (robot) ->
  robot.respond /(btc|ltc) ?(.*)/i, (msg) ->
    crypto = msg.match[1]
    fiat = (msg.match[2] || 'usd').trim().toLowerCase()
    coinPrice(msg, crypto, fiat)

symbols =
  usd: '$'
  eur: '€'

coinPrice = (msg, crypto, fiat) ->
  msg
    .send "Fetching..."
  msg
    .http("https://btc-e.com/api/2/#{crypto}_#{fiat}/ticker")
    .get() (err, res, body) ->
      tick = JSON.parse(body)['ticker']
      if err or not tick
        return msg.send "Sorry btc-e doesn't like that combination"

      symbol = symbols[fiat]
      msg.send "#{crypto.toUpperCase()}: #{symbol}#{tick['last']} (H: #{symbol}#{tick['high']} | L: #{symbol}#{tick['low']})"

