local elevador = {
    andar1 = vector3(-945.04, -2071.68, 9.74),
    andar2 = vector3(-952.41, -2074.21, 27.89),
    proximidade = 1.5
}

RegisterNUICallback("escolherAndar", function(data, cb)
    local ped = PlayerPedId()
    if data.andar == 1 then
        SetEntityCoords(ped, elevador.andar1.x, elevador.andar1.y, elevador.andar1.z)
    elseif data.andar == 2 then
        SetEntityCoords(ped, elevador.andar2.x, elevador.andar2.y, elevador.andar2.z)
    end
    cb("ok")
end)

RegisterNUICallback("fecharMenu", function(_, cb)
    SetNuiFocus(false, false)
    cb("ok")
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()
        local pCoords = GetEntityCoords(playerPed)

        for _, pos in pairs({elevador.andar1, elevador.andar2}) do
            local dist = #(pCoords - pos)
            if dist < elevador.proximidade then
                DrawMarker(1, pos.x, pos.y, pos.z - 1.0, 0, 0, 0, 0, 0, 0,
                    1.0, 1.0, 0.5, 255, 0, 0, 150, false, true, 2, false, nil, nil, false)
                DrawText3D(pos.x, pos.y, pos.z + 0.5, "[E] Elevador")

                if IsControlJustPressed(0, 38) then
                    SetNuiFocus(true, true)
                    SendNUIMessage({ action = "abrirMenu" })
                end
            end
        end
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local dist = #(vector3(x, y, z) - p)
    local scale = (1 / dist) * 1.2
    local fov = (1 / GetGameplayCamFov()) * 100
    scale = scale * fov

    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 0, 0, 215)
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
