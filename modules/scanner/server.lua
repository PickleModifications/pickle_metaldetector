local Scanners = {}

function UpdateScanners(source, index)
    TriggerClientEvent("pickle_metaldetector:updateScanner", source and source or -1, index, index and Scanners[index] or Scanners)
end

function GetRandomIndex()
    local index
    repeat
        index = os.time() .. "_" .. math.random(1000,9999)
    until not Scanners[index]
    return index
end

function CreateScanner(source, data)
    if source ~= nil and not CanAccessGroup(source, Config.Scanner.groups) then return end -- NOTIFY HERE 
    local index = GetRandomIndex()
    Scanners[index] = {
        location = data.location,
        heading = data.heading,
        hideObject = data.hideObject,
        owner = source
    }
    UpdateScanners(nil, index)
end

for i=1, #Config.ScannerLocations do 
    local scanner = Config.ScannerLocations[i]
    CreateScanner(nil, scanner)
end

RegisterNetEvent("pickle_metaldetector:requestScanners", function()
    local source = source
    UpdateScanners(source, nil)
end)

RegisterNetEvent("pickle_metaldetector:walkIntoScanner", function(index)
    local source = source
    local contraband = {}
    for i=1, #Config.Scanner.items do 
        local count = Search(source, Config.Scanner.items[i])
        if count > 0 then 
            table.insert(contraband, {label = GetItemLabel(Config.Scanner.items[i]), count = count})
        end
    end
    TriggerClientEvent("pickle_metaldetector:detectScanner", -1, index, contraband)
end)