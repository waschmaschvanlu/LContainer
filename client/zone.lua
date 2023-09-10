blipscreated = {}
containerscreated = {}
for k,v in pairs(Config.Zones) do

    --print(v.coords)
    point = lib.points.new({
        coords = v.coords,
        distance = v.radius,
        debug = true,
        id = k,
        amount = v.amount or 1
    })

function point:onEnter()
    isinazone = true
    --print('entered range of point', self.id)
    group = lib.callback.await('ludaro_container:getGroup', false)
   --print(group)
    model = Config.Containermodel
    local hash = GetHashKey(model)
    RequestModel(hash)
   if Config.Debug then
    zone = AddBlipForRadius(self.coords.x, self.coords.y, self.coords.z, self.distance * 2 + 0.0, self.distance * 2 + 0.0)
    SetBlipRotation(zone, 0)

      table.insert(blipscreated, zone)
   end
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
   randomcoords = getrandomcoords(self.coords, self.distance, self.amount)
   for k, container in pairs(randomcoords) do
   containercreated = CreateObject(hash, container.x, container.y, container.z, true, true, true)
--    --print("created container!")
   --SetEntityCoords(PlayerPedId(), container)
   table.insert(containerscreated, containercreated)

    --print(Config.BlipForadmins, group, Config.AdminGroup)
   if Config.BlipForadmins then
    if group == Config.AdminGroup then

        blip = AddBlipForEntity(containercreated)
        SetBlipSprite (blip, 1)
        SetBlipScale  (blip, 0.65)
        SetBlipDisplay(blip, 4)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING') 
        AddTextComponentString(name)
        EndTextCommandSetBlipName(blip)
        table.insert(blipscreated, blip)

       
    end
   end
   end

end
 
function point:onExit()
    --print('left range of point', self.id)
    isinazone = false
end
 
function point:nearby()
   
end
end


function getrandomcoords(coords, distance, amount)

    local randomCoords = {}
    for i = 1, amount do
        local randomX = coords.x + math.random(-distance, distance)
        local randomY = coords.y + math.random(-distance, distance)
        unusedBool, randomZ = GetGroundZFor_3dCoord(coords.x, coords.y, 99999.0, 1)
        table.insert(randomCoords, vector3(randomX, randomY, randomZ))
    end
    return randomCoords
end

function cleanup()
    for k,v in pairs(containerscreated) do
        DeleteObject(v)
      end
      for k,v in pairs(blipscreated) do 
        RemoveBlip(v)
      end
    end


AddEventHandler('onResourceStop', function(resourceName)
cleanup()
  end)