-- Define the marker position and properties
local markerPos = vector3(4903.2974, -4918.4976, 3.3862)
local small1 = vector3(4829.6382, -5027.2119, 31.5990)
local markerProperties = {
    type = 1,
    size = vector3(1200.001, 1200.0001, 600.5001),
    color = { r = 0, g = 208, b = 255, a = 200 },
}

local smallpro1 = {
    type = 1,
    size = vector3(200.001, 200.0001, 300.5001),
    color = { r = 255, g = 17, b = 0, a = 200 },
}

-- Define the initial marker size and the rate at which it will shrink
local initialSize = markerProperties.size
local shrinkRate = vector3(0.01, 0.01, 0.01)

-- Keep track of whether the marker is active
local isMarkerActive = false

-- Register the "startpubgzone" command to create the marker
RegisterCommand('startzone', function(source, args)
    -- Get the player's server ID
    local playerId = source


    -- Check if the player is authorized to use the command (if necessary)
    -- Replace this with your own authorization logic

    -- Create the marker at the specified position repeatedly in a loop
    Citizen.CreateThread(function()
        isMarkerActive = true -- Set the marker as active
        while isMarkerActive do
            DrawMarker(
                markerProperties.type,
                markerPos.x,
                markerPos.y,
                markerPos.z,
                0, 0, 0, 0, 0, 0,
                markerProperties.size.x,
                markerProperties.size.y,
                markerProperties.size.z,
                markerProperties.color.r,
                markerProperties.color.g,
                markerProperties.color.b,
                markerProperties.color.a,
                0, 0, 0, 0
            )
            Citizen.Wait(0)
        end
    end)
end, false)

-- Register the "shrinkpubgzone" command to shrink the marker
RegisterCommand('shrinkzone', function(source, args)
    -- Get the player's server ID
    local playerId = source

    -- Check if the player is authorized to use the command (if necessary)
    -- Replace this with your own authorization logic

    -- Create a separate thread to handle the marker shrinking logic
    Citizen.CreateThread(function()
        while true do
            -- Update the marker size by subtracting the shrink rate
            markerProperties.size = markerProperties.size - shrinkRate

            -- Check if the marker has reached a minimum size
            if markerProperties.size.x <= 0 or markerProperties.size.y <= 0 or markerProperties.size.z <= 0 then
                -- Reset the marker size to the initial size
                markerProperties.size = initialSize
                isMarkerActive = false -- Set the marker as inactive
                break  -- Exit the loop once the marker has shrunk to a minimum size
            end

            Citizen.Wait(10)
        end
    end)
end, false)

-- Register the "stoppubgzone" command to stop the marker
RegisterCommand('stopzone', function(source, args)
    -- Get the player's server ID
    local playerId = source

    -- Check if the player is authorized to use the command (if necessary)
    -- Replace this with your own authorization logic

    isMarkerActive = false -- Set the marker as inactive
end, false)
