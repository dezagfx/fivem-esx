ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('teste', function(text)
    local playerId = PlayerPedId()
    TriggerClientEvent('teste', playerId, 'Ola vacie')
end)

RegisterCommand("players", function(source, args)
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

        print(('Aqui estão todos os players online: %s'):format(xPlayers[i]))
    end
end)