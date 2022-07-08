local function OnPlayerConnecting(name, setKickReason, deferrals)
  local player = source
  local steamIdentifier
  local ip
  local identifiers = GetPlayerIdentifiers(player)
  deferrals.defer()

  -- mandatory wait!
  Wait(0)

  deferrals.update(string.format("Hello %s. Your Steam ID is being checked.", name))

  for _, v in pairs(identifiers) do
      if string.find(v, "steam") then
          steamIdentifier = v
      end
      if string.find(v, "ip") then
        ip = v
      end
  end

  ip = ip:gsub("ip:", "")

  print("ip: " .. ip, "steam: " .. steamIdentifier)

  Wait(0)

  PerformHttpRequest("http://localhost:3000/check/" .. ip .. "/" .. steamIdentifier, function(err, data, headers)
    if data == "true" then
      deferrals.done("girdi")
    else
      deferrals.done("Blacklistesin askim <3.")
    end
  end)

end

AddEventHandler("playerConnecting", OnPlayerConnecting)

RegisterCommand("blacklist", function(source,args)
  local ip = args[1]
  local steam = args[2]

  PerformHttpRequest("http://localhost:3000/addbanedplayer/" .. ip .. "/" .. steam, function(err, data, headers) end)
  print("added ip: " .. ip, "steam: " .. steam)
end)