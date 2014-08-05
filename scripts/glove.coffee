# Description:
# Get power of glove pledge
#
# Dependencies:
# cheerio
#
# Configuration:
# None
#
# Commands:
# maeve kick me
#
# Author:
# bhelx

cheerio = require 'cheerio'

module.exports = (robot) ->
  robot.respond /kick me/i, (msg) ->
    kickMe msg

kickstarter_url = "https://www.kickstarter.com/projects/powerglove/the-power-of-glove-a-power-glove-documentary"

kickMe = (msg) ->
  msg
    .send "Fetching pledge amount..."

  msg
    .http(kickstarter_url)
    .get() (err, res, body) ->
      $ = cheerio.load(body)
      pledge = $('#pledged > data').first().text()

      msg.reply "The current pledge is #{pledge}"

