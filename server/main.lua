ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("stress:add")
AddEventHandler("stress:add", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerClientEvent("esx_status:add", _source, "stress", value)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Stresin artıyor!'})
end)

RegisterServerEvent("stress:remove")
AddEventHandler("stress:remove", function (value)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

        TriggerClientEvent("esx_status:remove", _source, "stress", value)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Stresin azalıyor!'})
end)
