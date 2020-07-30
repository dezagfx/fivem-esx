ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()
end)

RegisterCommand("id", function(source, raw, args)
	ESX.ShowNotification("ID: ~g~" .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
end, false)

RegisterCommand("coo", function()
    print(GetEntityCoords(PlayerPedId()))
end)


