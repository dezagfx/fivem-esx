ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('output')
AddEventHandler('output', function(argument)
    TriggerEvent("chatMessage", "[Report]: ", {255,0,0}, "Report" .. argument .. "sent to admins")
end)
--------------------------------
local isMenuOpen = false
local options = {
    {label = "Spawn Carbine afenx -.-", value = 'spawn_carbine'}, --spawn carabine rifle
    {label = "Suicide", value = 'suicide'}, --commit suicide
    {label = 'id', value = 'id'} --show self id
}

function OpenMenu()
    isMenuOpen = true
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rp_menu',{
        title    = "RP Menu",
        align    = "rigth",
        elements = options
    }, function(data, menu)
        menu.close()
        isMenuOpen = false
        if data.current.value == 'spawn_carbine' then
            SpawnCarbine()
        end
        if data.current.value == 'suicide' then
            Suicide()
        end
        if data.current.value == 'id' then
            ShowId()
        end
    end,
    function(data, menu)
        menu.close()
        isMenuOpen = false
    end)
end

function SpawnCarbine()
    GiveWeaponToPed(PlayerPedId(), GetHashKey("WEAPON_CARBINERIFLE"), 300, 0, 1)
    ESX.ShowNotification('Recebeste uma carabina enviada pelos deuses')
end

function Suicide()
    ESX.ShowNotification("WASTED")
    SetEntityHealth(PlayerPedId(), 0)
end



Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0,47) and not isMenuOpen then
            OpenMenu()
        end
        Citizen.Wait(10)
    end

end)



