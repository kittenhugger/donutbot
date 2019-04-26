# donut.coffee
#
# Commands:
#   hubot donutstatus - Return back the number of donuts still available.
# Do an inquiry to our donut status script, and let the requesting user know what we found.

# { spawn } = require 'child_process'
fakenumberOfDonuts = "0"

#function hasWhiteSpace(s) {
#  return /\s/g.test(s);
#}

module.exports = (robot) ->
  robot.hear /(donutstatus)/i, (msg) ->
    @exec = require('child_process').exec
    command = "/home/mkuenning/donutbot/node_modules/hubot-donut/src/getdonutpic.sh"
    command2 = "/home/mkuenning/donutbot/node_modules/hubot-donut/src/donutdetect.sh"
    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stderr

    text = msg.message.text

    @exec command2, (error, stdout, stderr) ->
      randomNumber = Math.floor(Math.random() * 30) + 1
      console.log "Generated random number #{randomNumber}"

      numberOfDonuts = stdout
      console.log "Number of donuts detected #{stdout}"

      sNumberOfDonuts = numberOfDonuts.toString()
      s2NumberOfDonuts = sNumberOfDonuts.trim()

      if randomNumber==30
        randomNumber2 = Math.floor(Math.random() * 1000) + 1
        msg.send "The number of donuts available is currently #{randomNumber2}"      

      else if s2NumberOfDonuts == "0"
        msg.send "There are currently no donuts here :cry:"
      else
        msg.send "The number of donuts available is currently #{numberOfDonuts}"

      msg.send error
      # msg.send stdout
      msg.send stderr
