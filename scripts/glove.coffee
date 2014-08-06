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
kickstarter_url = "https://www.kickstarter.com/projects/powerglove/the-power-of-glove-a-power-glove-documentary"
period = 10000 # every 10 seconds
interval = null
pledge = null

module.exports = (robot) ->

  fetch_pledge = (done) ->
    robot.http(kickstarter_url)
      .get() (err, res, body) ->
        return done(err) if err

        $ = cheerio.load(body)
        new_pledge = $('#pledged > data').first().text()

        done(err, new_pledge)

  robot.respond /kick me/i, (msg) ->
    fetch_pledge (err, pledge) ->
      msg.reply "The current pledge is #{pledge}"

  robot.respond /kick start/i, (msg) ->
    interval = setInterval () ->
      fetch_pledge (err, new_pledge) ->
        if pledge != new_pledge
          msg.send "Pledge changed from #{pledge} to #{new_pledge}"
          pledge = new_pledge
    , period
    msg.send "Started pledge watcher"

  robot.respond /kick stop/i, (msg) ->
    clearInterval interval
    msg.send "Stopped pledge watcher"

