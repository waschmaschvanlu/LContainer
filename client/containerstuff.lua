RegisterCommand('testc', function(source, args, rawCommand)

animDict = "anim@scripted@player@mission@tunf_train_ig1_container_p1@heeled@"
    local ped = PlayerPedId()
    local model = "prop_container_05a"
    local hash = GetHashKey(model)
    local hash2 = GetHashKey("tr_prop_tr_grinder_01a")
    local hash3 = GetHashKey("ch_p_m_bag_var04_arm_s")
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    RequestModel(hash2)
    while not HasModelLoaded(hash2) do
        Citizen.Wait(0)
    end

    RequestModel(hash3)
    while not HasModelLoaded(hash3) do
        Citizen.Wait(0)
    end

    targetPosition = vector3(-298.0921 + 20, -2570.2095, 6.0006)
    animPos = GetOffsetFromEntityInWorldCoords(container, 0.0, 0.0, 0.0)

    container = CreateObject(hash, GetEntityCoords(PlayerPedId()), true, false, false)
    -- FreezeEntityPosition(container, false)
    -- animPos = GetOffsetFromEntityInWorldCoords(container, 0.0, 0.0, 0.0)
    -- netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0.0, 1.3)
    -- grinder = CreateObject(GetHashKey("tr_prop_tr_grinder_01a"), animPos, true, true, false)
    -- bag = CreateObject(GetHashKey("ch_p_m_bag_var04_arm_s"), targetPosition, true, true, false)

    -- while not HasAnimDictLoaded(animDict) do
    --     RequestAnimDict(animDict)
    --     Wait(1)
    -- end
    -- fxName = "scr_indep_fireworks"
    -- lib.requestAnimDict(animDict)
    -- lib.requestNamedPtfxAsset(fxName)

    -- NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "action", 1.5, -4.0, 1, 16, 1148846080, 0)
    -- NetworkAddEntityToSynchronisedScene(ped, netScene, animDict, "action_lock", 4.0, -8.0, 1)
    -- NetworkAddEntityToSynchronisedScene(grinder, netScene, animDict, "action_angle_grinder", 4.0, -8.0, 1)

    -- NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "action_bag", 4.0, -8.0, 1)
    -- NetworkAddEntityToSynchronisedScene(container, netScene, animDict, "action_container", 4.0, -8.0, 1)

    -- NetworkStartSynchronisedScene(netScene)
    -- Wait(5300)
    -- NetworkStopSynchronisedScene(netScene)
    -- DeleteObject(grinder)
    -- DeleteObject(bag)


end)

insinazone = false

  isAtContainer = false

  Citizen.CreateThread(function()
    while true do
        playerPos = GetEntityCoords(PlayerPedId())
 nearbyobjects = GetClosestObjectOfType(playerPos, 1.5, GetHashKey(Config.Containermodel), false, false, false)

 if nearbyobjects ~= 0 then
    isAtContainer = true
 else
    isAtContainer = false
 end
 Citizen.Wait(350)
 
    end
  end)


  Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
  if isAtContainer and isinazone == true then

    showInfoBar("Press ~INPUT_CONTEXT~ to open container")
    if IsControlJustReleased(0, 38) then
     opencontainer()
    end
    end
   -- --print(isAtContainer)
    end
  end)

  

  function showInfoBar(msg)
    currentActionMsg = msg
    SetTextComponentFormat('STRING')
    AddTextComponentString(currentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  end

  
  function opencontainer()
    hasitem = lib.callback.await('ludaro_container:hasItem', false)
 if hasitem then

    local model = Config.Containermodel
    ped = PlayerPedId()
    local hash = GetHashKey(model)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(0)
    end
    --print("ah")
    animDict = "anim@scripted@player@mission@tunf_train_ig1_container_p1@heeled@"
    playerPos = GetEntityCoords(PlayerPedId())
    container = GetClosestObjectOfType(playerPos, 1.5, GetHashKey(Config.Containermodel), false, false, false)
    targetRotation = GetEntityRotation(ped)
    animPos = GetOffsetFromEntityInWorldCoords(container, 0.0, 0.0, 0.0)
    netScene = NetworkCreateSynchronisedScene(animPos, targetRotation, 2, false, false, 1065353216, 0.0, 1.3)
    grinder = CreateObject(GetHashKey("tr_prop_tr_grinder_01a"), animPos, true, true, false)
    bag = CreateObject(GetHashKey("ch_p_m_bag_var04_arm_s"), targetPosition, true, true, false)
    hash2 = GetHashKey("tr_prop_tr_grinder_01a")
    hash3 = GetHashKey("ch_p_m_bag_var04_arm_s")
    while not HasAnimDictLoaded(animDict) do
        RequestAnimDict(animDict)
        Wait(1)
    end

    RequestModel(hash2)
    while not HasModelLoaded(hash2) do
        Citizen.Wait(0)
    end

    RequestModel(hash3)
    while not HasModelLoaded(hash3) do
        Citizen.Wait(0)
    end
    --print("here")
    fxName = "scr_indep_fireworks"
    lib.requestAnimDict(animDict)
    lib.requestNamedPtfxAsset(fxName)

    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "action", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(ped, netScene, animDict, "action_lock", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(grinder, netScene, animDict, "action_angle_grinder", 4.0, -8.0, 1)

    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "action_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(container, netScene, animDict, "action_container", 4.0, -8.0, 1)

    NetworkStartSynchronisedScene(netScene)
    Wait(5300)
    NetworkStopSynchronisedScene(netScene)
    DeleteObject(grinder)
    DeleteObject(bag)
    success = lib.skillCheck("easy", {'w', 'a', 's', 'd'})
    if success then
        --print('success')
        TriggerServerEvent('ludaro_container:giveItem')
    else
        --print('fail')
        Config.Notify("Du hast das Schloss nicht geknackt!")
    end
else
    Config.Notify("Dir fehlt das Item :( Du brauchst ein/e"..Config.ItemName.." um den Container zu öffnen!")
  end
end
