if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

function ServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb,  ...)
end

function ShowNotification(text)
	QBCore.Functions.Notify(text)
end

function ShowHelpNotification(text)
    AddTextEntry('qbHelpNotification', text)
    BeginTextCommandDisplayHelp('qbHelpNotification')
    EndTextCommandDisplayHelp(0, false, false, -1)
end

function GetPlayersInArea(coords, maxDistance)
    return QBCore.Functions.GetPlayersFromCoords(coords, maxDistance)
end

function GetClosestPlayer()
    return QBCore.Functions.GetClosestPlayer()
end

function CanAccessGroup(data)
    if not data then return true end
    local pdata = QBCore.Functions.GetPlayerData()
    for k,v in pairs(data) do 
        if (pdata.job.name == k and pdata.job.grade.level >= v) then return true end
    end
    return false
end 

function GiveKeys(vehicle)
end

function ToggleDutyEvent(onduty)
    if onduty then 
        local gender = QBCore.Functions.GetPlayerData().charinfo.gender
        local outfit = gender == 1 and Config.Workplace.outfit.female or Config.Workplace.outfit.male
        if not outfit then return end 
        TriggerEvent('qb-clothing:client:loadOutfit', {outfitData = outfit})
    else
        TriggerServerEvent("qb-clothes:loadPlayerSkin")
    end
end

function GetConvertedClothes(oldClothes)
    local clothes = {}
    local components = {
        ['arms'] = "arms",
        ['tshirt_1'] = "t-shirt", 
        ['torso_1'] = "torso2", 
        ['bproof_1'] = "vest",
        ['decals_1'] = "decals", 
        ['pants_1'] = "pants", 
        ['shoes_1'] = "shoes", 
        ['helmet_1'] = "hat", 
    }
    local textures = {
        ['tshirt_1'] = 'tshirt_2', 
        ['torso_1'] = 'torso_2',
        ['bproof_1'] = 'bproof_2',
        ['decals_1'] = 'decals_2',
        ['pants_1'] = 'pants_2',
        ['shoes_1'] = 'shoes_2',
        ['helmet_1'] = 'helmet_2',
    }
    for k,v in pairs(oldClothes) do 
        local component = components[k]
        if component then 
            local texture = textures[k] and (oldClothes[textures[k]] or 0) or 0
            clothes[component] = {item = v, texture = texture}
        end
    end
    return clothes
end

CreateThread(function()
    for k,v in pairs(Config.Workplace.outfit) do
        Config.Workplace.outfit[k] = GetConvertedClothes(Config.Workplace.outfit[k])
    end
end)

RegisterNetEvent(GetCurrentResourceName()..":showNotification", function(text)
    ShowNotification(text)
end)