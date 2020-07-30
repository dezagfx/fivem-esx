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


RegisterCommand("dinheiro", function(source, args, rawCommand)
    ESX.TriggerServerCallback("teste:money", function(dinheiro)
        ESX.ShowNotification("Voce tem: ~g~"..dinheiro.."$ ~w~ na sua carteira.")
    end)
end)

RegisterCommand("id", function(source, raw, args)
	ESX.ShowNotification("ID: ~g~" .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
end, false)

RegisterCommand("help", function())
    TriggerEvent('chat:addMessage', {
        color = {255,0,0},
        multiline = true,
        args = {'[SERVER]', 'Scripting 4life'} --prefix and message
    })

