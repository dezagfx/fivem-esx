ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}

RegisterCommand("r", function(source, args)
    local argString = table.concat(args, " ")

    MySQL.Async.fetchAll("INSERT INTO reports (playerid, name, comment) VALUES(@source, @name, @args)",
    {["@source"] = source, ["@name"] = GetPlayerName(source), ["@args"] = argString},
        TriggerClientEvent("output", source, "^2"..argString.."^0")
    )
end)


RegisterCommand("get", function(source, args)
    local argString = table.concat(args, " ")
    MySQL.Async.fetchAll("SELECT * FROM reports WHERE status = 'waiting' ORDER BY id DESC LIMIT 5", {},
    function(result)
        local string = "^3(".. result[1].name .. ") - ^8".. result[1.id] .. "^0: " .. result[1].comment
        TriggerClientEvent("output", source, string)
    end)

end)

