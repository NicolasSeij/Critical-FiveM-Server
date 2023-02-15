local rentedVehicles = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('sqz_carrental:RentVehicle')
AddEventHandler('sqz_carrental:RentVehicle', function(model, insurance, price, time, rentalIndex)
    time = time:gsub('min', '')
    time =  tonumber(time)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price + Config.DownPayment then
        xPlayer.removeMoney(price + Config.DownPayment)
        xPlayer.showNotification('Has pagado '..price..'$')
        xPlayer.showNotification('Has pagado '..Config.DownPayment..'$ como pago inicial')
        TriggerClientEvent('sqz_carrental:SpawnVehicle', source, model, insurance, price, time, rentalIndex)
    elseif xPlayer.getAccount('bank').money >= price + Config.DownPayment then
        xPlayer.removeAccountMoney('bank', price + Config.DownPayment)
        xPlayer.showNotification('Has pagado '..Config.DownPayment..'$ como pago inicial de su cuenta bancaria')
        xPlayer.showNotification('Has pagado '..price..'$ de tu cuenta bancaria')
        TriggerClientEvent('sqz_carrental:SpawnVehicle', source, model, insurance, price, time, rentalIndex)
    else
        xPlayer.showNotification('No puede permitirse alquilar este vehículo')
    end
end)

RegisterNetEvent('sqz_carrental:VehicleSpawned')
AddEventHandler('sqz_carrental:VehicleSpawned', function(plate, insurance, time, netId)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if not rentedVehicles[plate] then
        rentedVehicles[plate] = {
            owner = xPlayer.identifier,
            insurance = insurance,
            netId = netId,
            downPayment = Config.DownPayment
        }
        SetTimeout(time * 60 * 1000 + 5000, function()
            local plate = GetVehicleNumberPlateText(NetworkGetEntityFromNetworkId(netId))
            if rentedVehicles[plate] then
                if GetPlayerPing(rentedVehicles[plate].owner) > 5 then
                    Citizen.CreateThread(function()
                        
                        while true do
                            Wait(1000 * 60)
                            if rentedVehicles[plate].downPayment >= Config.ExtraChargePerMinute then
                                rentedVehicles[plate].downPayment = rentedVehicles[plate].downPayment - Config.ExtraChargePerMinute
                            else
                                if ESX.GetPlayerFromId(_source) then
                                    xPlayer.showNotification('El depósito no será reembolsado, porque no ha devuelto el vehículo')
                                    xPlayer.showNotification('El vehículo ha sido incautado')
                                end
                                DeleteEntity(NetworkGetEntityFromNetworkId(netId))
                                rentedVehicles[plate] = nil
                            end
                        end
                    end)
                else
                    rentedVehicles[plate] = nil
                    DeleteEntity(NetworkGetEntityFromNetworkId(netId))
                end
            end
        end)
    end
end)

RegisterNetEvent('sqz_carrental:ReturnVehicle')
AddEventHandler('sqz_carrental:ReturnVehicle', function(plate, damageIndex)
    local xPlayer = ESX.GetPlayerFromId(source)
    if not rentedVehicles[plate] then
        xPlayer.showNotification('No puede devolver este vehículo porque este no ha sido alquilado.')
        return
    end

    if rentedVehicles[plate].owner ~= xPlayer.identifier then
        xPlayer.showNotification('No puede devolver este vehículo porque no es prestatario.')
        return
    end

    if rentedVehicles[plate].insurance then
        damageIndex = 1
    end

    local moneyToGive = math.floor(rentedVehicles[plate].downPayment * damageIndex)

    if damageIndex < 1 then
        local reducedBy = Config.DownPayment - Config.DownPayment * damageIndex
        xPlayer.showNotification('El pago inicial que debe recibir se ha reducido en '..reducedBy..'$ porque has devuelto el vehículo dañado')
    end

    xPlayer.addAccountMoney('bank', moneyToGive)
    xPlayer.showNotification('El pago inicial de la cantidad '..moneyToGive..'$ te ha sido devuelto.')
    TaskLeaveVehicle(GetPlayerPed(source), NetworkGetEntityFromNetworkId(rentedVehicles[plate].netId), 0)
    Wait(1700)
    DeleteEntity(NetworkGetEntityFromNetworkId(rentedVehicles[plate].netId))
    rentedVehicles[plate] = nil
    TriggerClientEvent('sqz_carrental:VehicleSuccessfulyReturned', xPlayer.source)
end)