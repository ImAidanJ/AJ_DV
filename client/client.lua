--  ___              _    _     _                 _ 
-- |_ _|_ __ ___    / \  (_) __| | __ _ _ __     | |
--  | || '_ ` _ \  / _ \ | |/ _` |/ _` | '_ \ _  | |
--  | || | | | | |/ ___ \| | (_| | (_| | | | | |_| |
-- |___|_| |_| |_/_/   \_\_|\__,_|\__,_|_| |_|\___/ 
-- 


-- DV Event --

RegisterNetEvent('AJ:DV')
AddEventHandler('AJ:DV', function()
    local playerPed = GetPlayerPed(-1);

    if (DoesEntityExist(playerPed) and not IsEntityDead(playerPed)) then
        local coords = GetEntityCoords(playerPed);

        if (IsPedSittingInAnyVehicle(playerPed)) then
            local vehicle = GetVehiclePedIsIn(playerPed, false)

            if (GetPedInVehicleSeat(vehicle, -1) == playerPed) then 
                DV(vehicle, 5)
            else
                TriggerEvent("chat:addMessage", {
                    template = '<div style="padding: 0.5vw; text-align: center; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px; color: white;"><b>{0}</b></div>', 
                    args = {"Must be in Driver Seat to Delete Vehicle."}
                })
            end
        else
            local playerLookingAt = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
            local vehicle = VehicleInDirection(playerPed, coords, playerLookingAt)

            if (DoesEntityExist(vehicle)) then 
                DV(vehicle, 5)
            else
                TriggerEvent("chat:addMessage", {
                    template = '<div style="padding: 0.5vw; text-align: center; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px; color: white;"><b>{0}</b></div>', 
                    args = {"Must be in or near Vehicle to Delete Vehicle."}
                })
            end
        end
    end
end)

-- Register Command --

RegisterCommand('dv', function()
    TriggerEvent('AJ:DV')
end, false)
TriggerEvent( "chat:addSuggestion", "/dv", "deletes vehicle your in or around." )

-- DV Function --

function DV(vehicle, timeoutMax)
    local timeout = 0

    SetEntityAsMissionEntity(vehicle, true, true)
    DeleteVehicle(vehicle)

    if (DoesEntityExist(vehicle)) then
        TriggerEvent("chat:addMessage", {
            template = '<div style="padding: 0.5vw; text-align: center; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px; color: white;"><b>{0}</b></div>', 
            args = {"Failed to Delete Vehicle.. Trying Again."}
        })

        while (DoesEntityExist(vehicle) and timeout < timeoutMax) do
            DeleteVehicle(vehicle)

            if (not DoesEntityExist(vehicle)) then
                TriggerEvent("chat:addMessage", {
                    template = '<div style="padding: 0.5vw; text-align: center; margin: 0.5vw; background-color: rgba(0, 255, 0, 0.6); border-radius: 3px; color: white;"><b>{0}</b></div>', 
                    args = {"Vehicle Deleted Successfully."}
                })
            end

            timeout = timeout + 1
            Citizen.Wait(500)

            if (DoesEntityExist(vehicle) and (timeout == timeoutMax - 1)) then
                TriggerEvent("chat:addMessage", {
                    template = '<div style="padding: 0.5vw; text-align: center; margin: 0.5vw; background-color: rgba(255, 0, 0, 0.6); border-radius: 3px; color: white;"><b>{0}</b></div>', 
                    args = {"Failed to delete vehicle after " .. timeoutMax .. " retries."}
                })
            end
        end
    else
        TriggerEvent("chat:addMessage", {
            template = '<div style="padding: 0.5vw; text-align: center; margin: 0.5vw; background-color: rgba(0, 255, 0, 0.6); border-radius: 3px; color: white;"><b>{0}</b></div>', 
            args = {"Vehicle Deleted Successfully."}
        })
    end
end

-- Vehicle Direction --
function VehicleInDirection(entFrom, coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)

    if (IsEntityAVehicle(vehicle)) then 
        return vehicle
    end
end