ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}

ESX.RegisterServerCallback("teste:money", function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pdinheiro = xPlayer.getMoney()

    cb(pdinheiro)
end)

RegisterCommand("reportar", function(source, args, rawCommand)	-- /report [MESSAGE]		send report message to all online admins
    local xPlayer = ESX.GetPlayerFromId(source)
  if onTimer[source] and onTimer[source] > GetGameTimer() then
      local timeLeft = (onTimer[source] - GetGameTimer()) / 1000
      xPlayer.triggerEvent('chatMessage', _U('report_cooldown', tostring(ESX.Math.Round(timeLeft))))
      return
  end
  if args[1] then
      local message = string.sub(rawCommand, 8)
      local xAll = ESX.GetPlayers()
      for i=1, #xAll, 1 do
            local xTarget = ESX.GetPlayerFromId(xAll[i])
            if havePermission(xTarget) then		-- you can exclude some ranks to NOT reciveing reports
              if xPlayer.playerId ~= xTarget.playerId then
                  xTarget.triggerEvent('chatMessage', _U('report', xPlayer.getName(), xPlayer.playerId, message))
              end
            end
      end
      xPlayer.triggerEvent('chatMessage', _U('report', xPlayer.getName(), xPlayer.playerId, message))
      onTimer[source] = GetGameTimer() + (Config.reportCooldown * 1000)
  else
      xPlayer.triggerEvent('chatMessage', _U('invalid_input', 'REPORT'))
  end
end, false)


function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end