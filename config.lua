Config = Config or {}

-- to use duration you have to add a progress bar in 'keep-drivingmodes:server:getVehicleStockSettings'

Config.mode_profiles = {
     police = {
          [0] = {
               label = 'off',
               settings = {
                    non_handling = {
                         EnginePowerMultiplier = 0.0,
                         duration = 2, --sec
                         intrupt_duration = 100 -- milisec
                    },
               }
          },
          [1] = {
               label = 'A+',
               settings = {
                    non_handling = {
                         EnginePowerMultiplier = 15.0,
                         duration = 2, --sec
                         intrupt_duration = 100 -- milisec
                    },
               }
          },
          [2] = {
               label = 'S',
               settings = {
                    non_handling = {
                         EnginePowerMultiplier = 30.0,
                         duration = 2, --sec
                         intrupt_duration = 100 -- milisec
                    },
               }
          },
          [3] = {
               label = 'S+',
               settings = {
                    non_handling = {
                         EnginePowerMultiplier = 150.0,
                         duration = 5, --sec
                         intrupt_duration = 200 -- milisec
                    },
               }
          },
     }
}

Config.vehicles = {
     ['adder'] = Config.mode_profiles.police
}

--- this is a server-side notification function
---@param source integer
---@param msg string
---@param _type string
function Notification(source, msg, _type)
     TriggerClientEvent('QBCore:Notify', source, msg, _type)
end
