local isMarkerActive = false
local isShrinkingPaused = false

RegisterCommand('startzone', function(source, args)
    local playerId = source

    Citizen.CreateThread(function()
        isMarkerActive = true
        while isMarkerActive do
            DrawMarker(
                Config.markerProperties.type,
                Config.zone.x,
                Config.zone.y,
                Config.zone.z,
                0, 0, 0, 0, 0, 0,
                Config.markerProperties.radius * 2,
                Config.markerProperties.radius * 2,
                Config.markerProperties.radius,
                Config.markerProperties.color.r,
                Config.markerProperties.color.g,
                Config.markerProperties.color.b,
                Config.markerProperties.color.a,
                0, 0, 0, 0
            )
            Citizen.Wait(0)
        end
    end)
end, false)

RegisterCommand('shrinkzone', function(source, args)
    local playerId = source

    Citizen.CreateThread(function()
        while true do
            Config.markerProperties.radius = Config.markerProperties.radius - Config.shrinkRate

            if Config.markerProperties.radius <= 0 then
                Config.markerProperties.radius = initialRadius
                isMarkerActive = false
                break
            end

            Citizen.Wait(10)
        end
    end)
end, false)


RegisterCommand('pausezone', function(source, args)
    local playerId = source

    isShrinkingPaused = true
end, false)

RegisterCommand('shrinkzone', function(source, args)
    local playerId = source

    isShrinkingPaused = false
end, false)

RegisterCommand('stopzone', function(source, args)
    local playerId = source

    isMarkerActive = false
end, false)
