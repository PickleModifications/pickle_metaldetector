RegisterNetEvent("pickle_metaldetector:searchWand", function(target)
    local source = source
    if not CanAccessGroup(source, Config.Wand.groups) then return ShowNotification(source, _L("group_denied")) end
    local contraband = {}
    for i=1, #Config.MetalItems do 
        local count = Search(target, Config.MetalItems[i])
        if count > 0 then 
            table.insert(contraband, {label = GetItemLabel(Config.MetalItems[i]), count = count})
        end
    end
    TriggerClientEvent("pickle_metaldetector:detectWand", -1, source, contraband)
end)

RegisterUsableItem("metal_wand", function(source)
    if not CanAccessGroup(source, Config.Wand.groups) then return ShowNotification(source, _L("group_denied")) end
    TriggerClientEvent("pickle_metaldetector:startWandSearch", source)
end)
