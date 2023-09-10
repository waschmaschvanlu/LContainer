Config = {}
Config.Zones = {
    {coords = vector3(-285.0057, -2573.5515, 6.0006), radius = 90, name = "Zone Name", amount = 3},
}
Config.Containermodel = "prop_container_05a"
Config.AdminGroup = "admin"
Config.BlipForadmins = true
Config.ItemName = "bread"
Config.TakeItem = true
Config.Notify = function(text)
    ESX.ShowNotification(text)
end
Config.Debug = false

Config.Reward = { -- Reward for opening the container
    ["money"] = {min = 100, max = 500},
    ["item"] = {name = "saw", min = 1, max = 3},
    ["weapon"] = {name = "WEAPON_PISTOL", min = 1, max = 1},
}