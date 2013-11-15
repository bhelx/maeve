# Description:
# Find the latest bitcoin prices
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# maeve btc [usd] - bitcoin command, fiat currency optional, defaults to usd
#
# Author:
# bhelx

module.exports = (robot) ->
  robot.respond /(btc|ltc) ?(.*)/i, (msg) ->
    coinPrice msg


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

      msg.send "#{crypto.toUpperCase()}: #{tick.return.last.display_short} (H: #{tick.return.high.display_short} | L: #{tick.return.low.display_short})"

