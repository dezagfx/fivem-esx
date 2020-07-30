ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback("teste:money", function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pdinheiro = xPlayer.getMoney()

    cb(pdinheiro)
end)

ESX.RegisterServerCallback("teste:pid", function(source,cb)
    local playerId = ESX.GetPlayerServerId(source)

    cb(playerId)
end)