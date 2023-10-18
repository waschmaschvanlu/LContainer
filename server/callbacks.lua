lib.callback.register('ludaro_container:getGroup', function(source)
    return getgroup(source)
end)


lib.callback.register('ludaro_container:hasItem', function(source)
if Config.NeedsItem then
return ESX.GetPlayerFromId(source).hasItem(Config.ItemName, 1).count > 0 or false
        else
return false
        end
end)
