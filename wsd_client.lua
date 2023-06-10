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
                Config.markerProperties.size.x,
                Config.markerProperties.size.y,
                Config.markerProperties.size.z,
                Config.markerProperties.color.r,
                Config.markerProperties.color.g,
                Config.markerProperties.color.b,
                Config.markerProperties.color.a,
                0, 0, 0, 0
            )
            Citizen.Wait(0)
            if not isShrinkingPaused then
                Config.markerProperties.size = Config.markerProperties.size - Config.shrinkRate

                if Config.markerProperties.size.x <= 0 or Config.markerProperties.size.y <= 0 or Config.markerProperties.size.z <= 0 then
                    Config.markerProperties.size = initialSize
                    isMarkerActive = false
                    break
                end
            end
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
