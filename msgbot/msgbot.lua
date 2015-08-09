require("ts3defs")
require("ts3errors")

local function sendToMusicBot(message)
      local botId = NULL
      local clients, error = ts3.getClientList(1)
      for i=1, #clients do
         local clientName, error = ts3.getClientVariableAsString(1, clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
         if clientName == "TS3MusicBot" then
            botId = clients[i]
         end
      end
      if botId ~= NULL then
         ts3.requestSendPrivateTextMsg(1, message, botId)
      else
         ts3.printMessageToCurrentTab("Can't reach TS3MusicBot")
      end
end

local function voldefault()
      cmd = "!volume 5"
      sendToMusicBot(cmd)
end

local function volup()
      cmd = "!volume +"
      sendToMusicBot(cmd)
end

local function voldown()
      cmd = "!volume -"
      sendToMusicBot(cmd)
end

msgbot = {
   voldefault = voldefault,
   volup = volup,
   voldown = voldown
}