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
  robot.respond /hanney to ([a-zA-Z]*)/i, (msg) ->
    user = msg.match[1]
    hanneyMe msg, user

hanneyMe = (msg, user) ->
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

      hanney = "http://doir.ir/mha/#{msg.random hanneys}"

      if user
        msg.reply "Hi #{user}! A special hanney for u #{hanney}"
      else
        msg.send hanney

