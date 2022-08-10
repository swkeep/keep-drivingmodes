--                _
--               | |
--   _____      _| | _____  ___ _ __
--  / __\ \ /\ / / |/ / _ \/ _ \ '_ \
--  \__ \\ V  V /|   <  __/  __/ |_) |
--  |___/ \_/\_/ |_|\_\___|\___| .__/
--                             | |
--                             |_|
-- https://github.com/swkeep

RegisterKeyMapping('+switchVehicleMode', 'Switch vehicle modes', 'keyboard', 'o')
RegisterCommand('+switchVehicleMode', function()
     local plyped = PlayerPedId()
     if (IsPedInAnyVehicle(plyped, false)) then
          if (IsPedInAnyVehicle(plyped, false)) then
               local veh = GetVehiclePedIsIn(PlayerPedId(), false)
               SwtichTheVehicleMode(veh)
          end
          Wait(1000)
     else
          TriggerServerEvent('keep-drivingmodes:server:Notification', "You must be insinde a vehicle to use this option!"
               , "error")
          Wait(1000)
          return
     end
end, false)

local function get_next_state(vehicle)
     local Promise = promise.new()
     local nedId = NetworkGetNetworkIdFromEntity(vehicle)

     TriggerCallback('keep-drivingmodes:server:getVehicleStockSettings', function(result)
          Promise:resolve(result)
     end, nedId)

     Citizen.Await(Promise)
     return Promise.value
end

function SwtichTheVehicleMode(vehicle)
     local playerped = PlayerPedId()
     local Driver = GetPedInVehicleSeat(vehicle, -1)
     if playerped ~= Driver then
          TriggerServerEvent('keep-drivingmodes:server:Notification', "You are not driver of this vehicle!", "error")
          return
     end
     local mode = get_next_state(vehicle)
     if not mode then
          TriggerServerEvent('keep-drivingmodes:server:Notification', "This vehicle do not have modes!", "error")
          return
     end
     local current = mode.current
     local settings = mode.vehicle_settings[current]
     local setting = settings.settings
     local duration = setting.non_handling.duration * 1000

     TriggerServerEvent('keep-drivingmodes:server:Notification', settings.label .. " Enabled", "primary")
     SetVehicleEnginePowerMultiplier(vehicle, setting.non_handling.EnginePowerMultiplier)

     CreateThread(function()
          local timeout = 0
          while timeout < setting.non_handling.intrupt_duration do
               SetVehicleCurrentRpm(vehicle, 0)
               timeout = timeout + 1
               Wait(1)
          end
     end)
end
