RegisterNetEvent('ludaro_container:giveItem')
AddEventHandler('ludaro_container:giveItem', function(job_name, job_label, grade)
    local rewards = {}
    for k,v in pairs(Config.Reward) do
        if k == "money" then
            local amount = math.random(v.min, v.max)
            table.insert(rewards, {type = "money", amount = amount})
        elseif k == "item" then
            local amount = math.random(v.min, v.max)
            table.insert(rewards, {type = "item", name = v.name, amount = amount})
        elseif k == "weapon" then
            local amount = math.random(v.min, v.max)
            table.insert(rewards, {type = "weapon", name = v.name, amount = amount})
        end
    end
    local reward = rewards[math.random(1, #rewards)]
    if reward.type == "money" then
        ESX.GetPlayerFromId(source).addMoney(reward.amount)
        ESX.GetPlayerFromId(source).showNotification("Du hast $" .. reward.amount .. " erhalten, indem du den Container geöffnet hast")
    elseif reward.type == "item" then
        ESX.GetPlayerFromId(source).addInventoryItem(reward.name, reward.amount)
        ESX.GetPlayerFromId(source).showNotification("Du hast " .. reward.amount .. " " .. reward.name .. " erhalten, indem du den Container geöffnet hast")
    elseif reward.type == "weapon" then
        ESX.GetPlayerFromId(source).addWeapon(reward.name, reward.amount)
        ESX.GetPlayerFromId(source).showNotification("Du hast " .. reward.amount .. " " .. reward.name .. " erhalten, indem du den Container geöffnet hast")
    end
    if Config.TakeItem then
        ESX.GetPlayerFromId(source).removeInventoryItem(Config.ItemName, 1)
    end
end)
