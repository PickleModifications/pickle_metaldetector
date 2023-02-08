function WandSearch()
    local closestPlayer = GetClosestPlayer()
    if not closestPlayer or closestPlayer == -1 or closestPlayer == PlayerId() or #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(closestPlayer))) > 2.0 then 
        return ShowNotification(_L("no_player"))
    end
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped) 
    local boneIndex = GetPedBoneIndex(ped, Config.Wand.boneID)
    local prop = CreateProp(Config.Wand.model, coords.x, coords.y, coords.z, true, true, false)
    local pos, rot = Config.Wand.offset.pos, Config.Wand.offset.rot
    AttachEntityToEntity(prop, ped, boneIndex, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, false, false, false, true, 2, true)
    PlayAnim(ped, Config.Wand.animation[1], Config.Wand.animation[2], -8.0, 8.0, -1, 49, 1.0, false, false, false)
    lib.progressCircle({duration = Config.Wand.searchTime, label = _L("wand_search"), position = "bottom"})
    TriggerServerEvent("pickle_metaldetector:searchWand", GetPlayerServerId(closestPlayer))
    DeleteEntity(prop)
    ClearPedTasks(ped)
end

RegisterNetEvent("pickle_metaldetector:detectWand", function(source, contraband) 
    local count = (#contraband > 0 and Config.Wand.failBeepCount or Config.Wand.successBeepCount)
    local str = _L("wand_title")..":  \n "
    if GetPlayerServerId(PlayerId()) == source then 
        isDisplayText = true 
        if #contraband > 0 then 
            if Config.Wand.displayItems then
                for i=1, #contraband do 
                    str = str .. contraband[i].label .. " (x"..contraband[i].count..")  \n "
                end
            else
                str = str .. _L("metal_detect")
            end
            lib.showTextUI(str)
        else
            lib.showTextUI(str .. _L("metal_none"))
        end
        local time = (250 * count) + 1000
        SetTimeout(time, function()
            isDisplayText = false
            lib.hideTextUI()
        end)
    end
    for i=1, count do 
        PlaySoundFromEntity(-1, "IDLE_BEEP", GetPlayerPed(GetPlayerFromServerId(source)), "EPSILONISM_04_SOUNDSET", 0, 0)
        Wait(200)
        StopSound(-1)
        Wait(70)
    end    
end)

RegisterNetEvent("pickle_metaldetector:startWandSearch", WandSearch)