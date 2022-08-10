--                _
--               | |
--   _____      _| | _____  ___ _ __
--  / __\ \ /\ / / |/ / _ \/ _ \ '_ \
--  \__ \\ V  V /|   <  __/  __/ |_) |
--  |___/ \_/\_/ |_|\_\___|\___| .__/
--                             | |
--                             |_|
-- https://github.com/swkeep

local vehicles = {}
local vehicles_config = {}

RegisterNetEvent('keep-drivingmodes:server:add', function(vehicle, state)
     vehicles[vehicle] = state
end)

local function findTheCar(veh)
     local model = GetEntityModel(veh)
     for key, value in pairs(vehicles_config) do
          if key == model then
               return value
          end
     end
     return false
end

CreateCallback('keep-drivingmodes:server:getVehicleStockSettings', function(source, cb, netId)
     local veh = NetworkGetEntityFromNetworkId(netId)
     local vehicle_settings = findTheCar(veh)
     if vehicle_settings == false then
          return cb(false)
     end
     if vehicles[veh] then
          vehicles[veh].current = vehicles[veh].current + 1
          if vehicles[veh].current > #vehicles[veh].vehicle_settings then
               vehicles[veh].current = 0
          end
          return cb(vehicles[veh])
     else
          vehicles[veh] = {
               netId = netId,
               veh = veh,
               current = 1,
               vehicle_settings = vehicle_settings
          }
          return cb(vehicles[veh])
     end
end)

CreateThread(function()
     for key, value in pairs(Config.vehicles) do
          vehicles_config[GetHashKey(key)] = value
     end
end)
