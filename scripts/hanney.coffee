# Description:
# Give me a hanney
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# maeve hanney me
#
# Author:
# bhelx

cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.respond /hanney me/i, (msg) ->
    hanneyMe msg

hanneyMe = (msg) ->
  hanneys = []

  msg
    .send "Fetching you a special Hanney..."

  msg
    .http("http://doir.ir/mha/")
    .get() (err, res, body) ->
      $ = cheerio.load(body)
      $('a').each (index, value) ->
        link = $(this).text()
        hanneys.push link if /.*\.jpg/.test(link)

      msg.reply "A special hanney for u http://doir.ir/mha/#{msg.random hanneys}"

