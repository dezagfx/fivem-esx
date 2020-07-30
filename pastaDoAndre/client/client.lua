local isMenuOpen = false
local options = {
    {label = "Spawn Carbine afenx -.-", value = 'spawn_carbine'}, --spawn carabine rifle
    {label = "Suicide", value = 'suicide'}, --commit suicide
    {label = 'id', value = 'id'}, --show self id
    {label = 'Teleport GP', value = 'GP'}
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
    ESX.ShowNotification(PlayerId())
end

function Teleport()
    local playerPed = PlayerPedId()

    ESX.Game.Teleport(playerPed, {x = 224.55, y = -807.225, z = 0, heading = 100.0}, function()
        print('this code is async!')
    end)
end

Citizen.CreateThread(function()
    while true do
        if IsControlJustReleased(0,47) and not isMenuOpen then
            OpenMenu()
        end
        Citizen.Wait(10)
    end

end)