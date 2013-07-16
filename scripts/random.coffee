# Description:
# Choose something random from a comma delimited list
#
# Dependencies:
# None
#
# Configuration:
# None
#
# Commands:
# maeve random item1, item2, itemN
# maeve choose item1, item2, itemN
#
# Author:
# bhelx


module.exports = (robot) ->
  robot.respond /(choose|random) ?(.*)/i, (msg) ->
    items = msg.match[2].split(',')
    if items.length < 2
      msg.reply "I need at least 2 choices ^_^"
    else
      msg.reply "I like #{msg.random(items).trim()}"

