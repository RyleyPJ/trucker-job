local truckingJob = false
local truckSpawned = false
local trailerSpawned = false

RegisterCommand("trucking", function()
    if not truckingJob then
        TriggerServerEvent('trucking:start')
    else
        TriggerServerEvent('trucking:stop')
        truckingJob = false
        print("Trucking job stopped")
        return
    end
end)

RegisterNetEvent("spawnTruck")
AddEventHandler("spawnTruck", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    if not truckSpawned then
        local truck = CreateObject(GetHashKey("prop_truck_01"), coords.x, coords.y, coords.z, true, true, true)
        AttachEntityToEntity(truck, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0)
        SetEntityAsMissionEntity(truck, true, true)

        RequestModel("haulerVehicle")
        while not HasModelLoaded("haulerVehicle") do
            Citizen.Wait(10)
        end

        truckSpawned = true
        print("Truck spawned")
    end
end)

RegisterNetEvent("spawnTrailer")
AddEventHandler("spawnTrailer", function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    RequestModel("trailervehicle")  -- Corrected the model name
    while not HasModelLoaded("trailervehicle") do
        Citizen.Wait(10)
    end

    local trailer = CreateVehicle("trailervehicle", coords.x, coords.y, coords.z, 0.0, true, false)
    AttachVehicleToTrailer(truck, trailer, 1.0)

    trailerSpawned = true
    print("Trailer spawned")
end)

RegisterNetEvent('startJob')
AddEventHandler('startJob', function()
    local playerPed = PlayerId()
    local coords = GetEntityCoords(playerPed)

    if not truckSpawned then
        TriggerEvent("spawnTruck")
    end

    if not trailerSpawned then
        TriggerEvent("spawnTrailer")
    end

    SetNewWaypoint(coords.x, coords.y)

    print("Job started - Truck and trailer spawned, waypoint set")
end)
