ESX              = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local isMenuOpen = false
local options = {
    {label = "Spawn Carbine afenx -.-", value = 'spawn_carbine'}, --spawn carabine rifle
    {label = "Suicide", value = 'suicide'}, --commit suicide
    {label = 'id', value = 'id'}, --show self id
    {label = 'Teleport GP', value = 'GP'},
    {label = 'CARABINA FUDIDA', value = 'carabina'}
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
        if data.current.value == 'GP' then
            Teleport()
        end
        if data.current.value == 'carabina' then
            CarabinaFDD()
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

function ShowId()
    ESX.ShowNotification(PlayerId(), 140)
end

function Teleport()
    local playerPed = PlayerPedId()
    ESX.Game.Teleport(playerPed, {x = 224.55, y = -807.225, z = 15.0, heading = 100.0}, function()
    end)
end

function CarabinaFDD() 
    GiveWeaponComponentToWeaponObject("WEAPON_CARBINERIFLE", "COMPONENT_AT_AR_SUPP", "COMPONENT_AT_AR_AFGRIP", "COMPONENT_CARBINERIFLE_CLIP_03" )
    ESX.ShowNotification('carabina lixada')
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0,47) and not isMenuOpen then
            OpenMenu()
        end
        Citizen.Wait(10)
    end

end)

-----------------
