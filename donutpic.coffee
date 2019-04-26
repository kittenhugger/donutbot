# donutpic.coffee
#
# Commands:
#   hubot donutpic - Return a live picture of what the DonutBot is seeing.

fs = require('fs');

module.exports = (robot) ->
  robot.hear /(donutpic)/i, (msg) ->
    sleep = (ms) ->
      start = new Date().getTime()
      console.log start
      continue while new Date().getTime() - start < ms

    @exec = require('child_process').exec
    command = "/home/mkuenning/donutbot/node_modules/hubot-donutpic/src/getdonutpic.sh"

    @exec command, (error, stdout, stderr) ->
        msg.send error
        msg.send stderr
        console.log stdout

    
    opts =
      file: fs.createReadStream('/home/mkuenning/donutbot/node_modules/hubot-donutpic/src/snapshot.jpg')
      channels: msg.message.room
    sleep 5000
    msg.robot.adapter.client.web.files.upload('snapshot.jpg', opts)
