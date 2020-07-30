ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("players", function(source, args)

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        print(('Aqui estão todos os players online: %s'):format(xPlayers[i]))
    end
end)


RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
    data.victim = source

    if data.killedByPlayer then
        TriggerClientEvent('esx:showNotification', -1, GetPlayerName(data.victim) .. 'foi morto por' .. GetPlayerName(data.killerServerId) .. ' de uma distancia de  ' .. data.distance .. ' metros')
    else
        TriggerClientEvent('esx:showNotification', -1, GetPlayerName(data.victim) .. ' morreu')
    end
end)