# Description:
# Give me a hanney
#
# Dependencies:
# set HANNEY_URL
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

hanney_url = process.env.HANNEY_URL

module.exports = (robot) ->
  robot.respond /hanney me/i, (msg) ->
    hanneyMe msg

hanneyMe = (msg) ->
  hanneys = []

  msg
    .send "Fetching you a special Hanney..."

  msg
    .http(hanney_url)
    .get() (err, res, body) ->
      $ = cheerio.load(body)
      $('a').each (index, value) ->
        link = $(this).text()
        hanneys.push link if /.*\.jpg/.test(link)

      msg.reply "A special hanney for u #{hanney_url}#{msg.random hanneys}"

