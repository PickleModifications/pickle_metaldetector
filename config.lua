Config = {}

Config.Language = "en"

Config.Debug = true

Config.RenderDistance = 100.0

Config.ScannerLocations = {
    {
        location = vec3(439.7059, -982.7385, 29.6896),
        heading = 86.5372,
        hideObject = false, -- Don't show the scanner prop (Useful for scanners already on the map).
    }
}

Config.MetalItems = { -- List of Detected Items
    "weapon_dagger",
    "weapon_bat",
    "weapon_bottle",
    "weapon_crowbar",
    "weapon_unarmed",
    "weapon_flashlight",
    "weapon_golfclub",
    "weapon_hammer",
    "weapon_hatchet",
    "weapon_knuckle",
    "weapon_knife",
    "weapon_machete",
    "weapon_switchblade",
    "weapon_nightstick",
    "weapon_wrench",
    "weapon_battleaxe",
    "weapon_poolcue",
    "weapon_stone_hatchet",
    "weapon_pistol",
    "weapon_pistol_mk2",
    "weapon_combatpistol",
    "weapon_appistol",
    "weapon_stungun",
    "weapon_pistol50",
    "weapon_snspistol",
    "weapon_snspistol_mk2",
    "weapon_heavypistol",
    "weapon_vintagepistol",
    "weapon_flaregun",
    "weapon_marksmanpistol",
    "weapon_revolver",
    "weapon_revolver_mk2",
    "weapon_doubleaction",
    "weapon_raypistol",
    "weapon_ceramicpistol",
    "weapon_navyrevolver",
    "weapon_microsmg",
    "weapon_smg",
    "weapon_smg_mk2",
    "weapon_assaultsmg",
    "weapon_combatpdw",
    "weapon_machinepistol",
    "weapon_minismg",
    "weapon_raycarbine",
    "weapon_pumpshotgun",
    "weapon_pumpshotgun_mk2",
    "weapon_sawnoffshotgun",
    "weapon_assaultshotgun",
    "weapon_bullpupshotgun",
    "weapon_musket",
    "weapon_heavyshotgun",
    "weapon_dbshotgun",
    "weapon_autoshotgun",
    "weapon_assaultrifle",
    "weapon_assaultrifle_mk2",
    "weapon_carbinerifle",
    "weapon_carbinerifle_mk2",
    "weapon_advancedrifle",
    "weapon_specialcarbine",
    "weapon_specialcarbine_mk2",
    "weapon_bullpuprifle",
    "weapon_bullpuprifle_mk2",
    "weapon_compactrifle",
    "weapon_mg",
    "weapon_combatmg",
    "weapon_combatmg_mk2",
    "weapon_gusenberg",
    "weapon_sniperrifle",
    "weapon_heavysniper",
    "weapon_heavysniper_mk2",
    "weapon_marksmanrifle",
    "weapon_marksmanrifle_mk2",
    "weapon_rpg",
    "weapon_grenadelauncher",
    "weapon_grenadelauncher_smoke",
    "weapon_minigun",
    "weapon_firework",
    "weapon_railgun",
    "weapon_hominglauncher",
    "weapon_compactlauncher",
    "weapon_rayminigun",
    "weapon_grenade",
    "weapon_bzgas",
    "weapon_smokegrenade",
    "weapon_flare",
    "weapon_molotov",
    "weapon_stickybomb",
    "weapon_proxmine",
    "weapon_snowball",
    "weapon_pipebomb",
    "weapon_ball",
    "weapon_petrolcan",
    "weapon_fireextinguisher",
    "weapon_parachute",
    "weapon_hazardcan",
}

Config.Scanner = {
    model = `ch_prop_ch_metal_detector_01a`,
    displayItems = true, -- Display all detected items found on the person, or just detect metal.
    failBeepCount = 8, -- Beeps for finding metal
    successBeepCount = 1, -- Beeps for not finding metal
    notifyDistance = 3.0, -- Display Text Distance
    flashDistance = 20.0, -- Object Flash Distance
    groups = { -- Groups that see the display text
        ["police"] = 0,
    },
    items = Config.MetalItems -- Items the scanner can detect
}

Config.Wand = {
    item = "metal_wand",
    model = `prop_parking_wand_01`,
    displayItems = false, -- Display all detected items found on the person, or just detect metal.
    failBeepCount = 8, -- Beeps for finding metal
    successBeepCount = 1, -- Beeps for not finding metal
    searchTime = 5000, -- Time for scanning
    boneID = 0xDEAD,
    offset = {
        pos = vec3(0.12, 0.05, 0.0),
        rot = vec3(80.0, -20.0, 180.0),
    },
    animation = {"amb@world_human_car_park_attendant@male@base", "base"},
    items = Config.MetalItems -- Items the scanner can detect
}