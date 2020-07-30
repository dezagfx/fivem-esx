ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}

ESX.RegisterServerCallback("teste:money", function(source,cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pdinheiro = xPlayer.getMoney()

    cb(pdinheiro)
end)

RegisterCommand("r", function(source, args)
    local argString = table.concat(args, " ")

    MySQL.Async.fetchAll("INSERT INTO reports (id, name, args) VALUES(@source, @name, @args)",
    {["@source"] = source, ["@name"] = GetPlayerName(source), ["@args"] = argString},
        TriggerClientEvent("output", source, "^2"..argString.."^0")
    )
end)


