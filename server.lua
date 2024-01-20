local truckingJob = false

-- Registering the command for the job 

RegisterCommand("trucking", function()
    if truckingJob then
        TriggerClientEvent("chat:addMessage", -1, { args = { "^1Trucking job is already running" } })
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    end
end)

-- Code to spawn the vehicle 

function createVehicle(vehicle, playerPed)
    RequestModel(haulervehicle)
    while not HasModelLoaded(hauler(vehicle)) do
        Citizen.Wait(0)

    end

-- Code to spawn the truck

function spawnVehicle(playerPed, vehicle)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(hauler(vehicle), coords.x, coords.y, coords.z, 0.0, true, true)
    SetEntityAsMissionEntity(vehicle, true, true)
    SetPedIntoVehicle(playerPed, vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, true)
end

-- Code to spawn the trailer

function spawnTrailer(vehicle, playerPed)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = CreateVehicle(trailers(vehicle), coords.x, coords.y, coords.z, 0.0, true, true)
    SetEntityAsMissionEntity(vehicle, true, true)
end
end