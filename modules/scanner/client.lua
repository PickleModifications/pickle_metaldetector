local Scanners = {}
local LocalScanners = {}
local insideScanner
local isDisplayText
local displayThread

function GetLocalScanner(index)
    if LocalScanners[index] == nil then 
        return nil
    elseif Scanners[index] == nil then
        DeleteLocalScanner(index)
        return nil
    else
        return LocalScanners[index]
    end
end

function EnsureLocalScanner(index)
    local entity = GetLocalScanner(index)
    local data = Scanners[index]
    if entity then return entity end
    if not data then return nil end 
    local prop = CreateProp(Config.Scanner.model, data.location.x, data.location.y, data.location.z, false, true, false)
    if data.hideObject then 
        SetEntityAlpha(prop, 0)
        SetEntityCollision(prop, false, true)
    end
    FreezeEntityPosition(prop, true)
    SetEntityHeading(prop, data.heading)
    LocalScanners[index] = prop
    return prop
end

function DeleteLocalScanner(index) 
    DeleteEntity(LocalScanners[index])
    LocalScanners[index] = nil
end

function WalkIntoScanner(index)
    if insideScanner then return end
    insideScanner = index
    TriggerServerEvent("pickle_metaldetector:walkIntoScanner", index)
end

CreateThread(function()
    TriggerServerEvent("pickle_metaldetector:requestScanners")
    while true do 
        local wait = 1000
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        for k,v in pairs(Scanners) do 
            local coords = v.location
            local dist = #(coords - pcoords)
            if dist < Config.RenderDistance then 
                wait = 0
                local prop = EnsureLocalScanner(k)
                if prop then 
                    local offset = GetOffsetFromEntityInWorldCoords(prop, 0.0, 0.0, 0.5)
                    local dist = #(pcoords - offset)
                    local range = 0.85
                    if dist < range and not insideScanner and not (Config.IgnoreGroups and CanAccessGroup(Config.Scanner.groups)) then 
                        WalkIntoScanner(k)
                    elseif insideScanner and dist > range then
                        insideScanner = nil
                    end
                end
            elseif GetLocalScanner(k) then
                DeleteLocalScanner(k)
            end
        end
        Wait(wait)
    end
end)

RegisterNetEvent("pickle_metaldetector:updateScanner", function(index, data)
    if not index and data ~= nil then 
        Scanners = data
    elseif data ~= nil then
        Scanners[index] = data
        if data == nil then 
            DeleteLocalScanner(index)
        end
    end
end)

RegisterNetEvent("pickle_metaldetector:detectScanner", function(index, contraband)
    local data = Scanners[index]
    local prop = EnsureLocalScanner(index)
    if not data or not prop then return end 
    local count = (#contraband > 0 and Config.Scanner.failBeepCount or Config.Scanner.successBeepCount)
    local str = _L("scanner_title") .. ":  \n "
    local dist = #(GetEntityCoords(PlayerPedId()) - data.location)
    if not isDisplayText and dist < Config.Scanner.notifyDistance and CanAccessGroup(Config.Scanner.groups) then 
        isDisplayText = true 
        if #contraband > 0 then 
            if Config.Scanner.displayItems then
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
    if not displayThread then 
        displayThread = true
        local time = 250 * count
        local flashActive = false
    
        Citizen.CreateThread(function()
            if dist > Config.Scanner.flashDistance then return end
            SetEntityDrawOutline(prop, true)
            while displayThread do 
                if flashActive then
                    SetEntityDrawOutlineColor(255, 255, 255, 0)
                else
                    SetEntityDrawOutlineColor(255, 0, 0, 255)
                end
                Wait(0)
            end
            SetEntityDrawOutline(prop, false)
        end)
        for i=1, count do 
            flashActive = false
            PlaySoundFromEntity(-1, "IDLE_BEEP", prop, "EPSILONISM_04_SOUNDSET", 0, 0)
            Wait(200)
            flashActive = true
            StopSound(-1)
            Wait(70)
        end    
        displayThread = false
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k,v in pairs(LocalScanners) do 
        DeleteLocalScanner(k)
    end
end)
