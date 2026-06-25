local math_abs = math.abs
local math_rad = math.rad
local math_sin = math.sin
local math_cos = math.cos

local GetFinalRenderedCamCoord = GetFinalRenderedCamCoord
local GetFinalRenderedCamRot = GetFinalRenderedCamRot

local hasWeapon = false

local function rotationToDirection(rotation)
    local x = math_rad(rotation.x)
    local z = math_rad(rotation.z)
    local cosX = math_abs(math_cos(x))
    return vector3(-math_sin(z) * cosX, math_cos(z) * cosX, math_sin(x))
end

local function handleRaycast(start, destination, flag, ignore)
    local handle = StartShapeTestRay(start.x, start.y, start.z, destination.x, destination.y, destination.z, flag, ignore,
        1)
    local _, hit, endCoords, _, entityHit = GetShapeTestResult(handle)

    return hit, endCoords, entityHit
end

lib.onCache("weapon", function(weapon)
    if not weapon then
        hasWeapon = false
        return
    end

    local weaponType = GetWeapontypeGroup(weapon)
    if weaponType == -728555052 or weaponType == -1609580060 then
        hasWeapon = false
        return
    end
    hasWeapon = true

    CreateThread(function()
        local ped = cache.ped
        local playerId = cache.playerId
        local displayText = Config.DisplayText
        local textIcon = Config.Text
        local lastNotifyTime = 0

        while hasWeapon do
            if IsPlayerFreeAiming(playerId) then
                local weaponEnt = GetCurrentPedWeaponEntityIndex(ped)
                local camRot = GetFinalRenderedCamRot()
                local camCoord = GetFinalRenderedCamCoord()
                local dir = rotationToDirection(camRot)
                local destinationFar = camCoord + (dir * 1000.0)
                local weaponCoord = GetEntityCoords(weaponEnt)

                local hitW, coordsW, _ = handleRaycast(weaponCoord, camCoord + (dir * 15.0), 1, ped)
                local hitC, _, coordsC = lib.raycast.fromCamera(1, 4, 1000.0)

                if hitW == 1 and (#(coordsW - coordsC) > 1.0) then
                    if Config.Debug then
                        DrawLine(weaponCoord.x, weaponCoord.y, weaponCoord.z, coordsW.x, coordsW.y, coordsW.z, 255, 0, 0,
                            255)
                        DrawLine(camCoord.x, camCoord.y, camCoord.z, coordsC.x, coordsC.y, coordsC.z, 0, 0, 255, 255)
                    end

                    if displayText then
                        Draw3DText(coordsW.x, coordsW.y, coordsW.z, textIcon)
                    end

                    DisablePlayerFiring(ped, true)
                    DisableControlAction(2, 106)

                    if Config.Notify then
                        if IsDisabledControlJustPressed(2, 106) and GetGameTimer() - lastNotifyTime > (Config.NotifyInterval or 2500) then
                            lastNotifyTime = GetGameTimer()
                            lib.notify({
                                description = Config.NotificationText,
                                type = "error",
                            })
                        end
                    end
                end
            else
                Wait(500)
            end
        end
    end)
end)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        SetTextScale(0.3, 0.3)
        SetTextFont(0)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextOutline()
        BeginTextCommandDisplayText("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end
