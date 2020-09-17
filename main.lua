ESX = nil

local PlayerData = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'stress', 1000000, '#cadfff', function(status)
		return false
	end, function(status)
		status.add(1)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1)
			local ped = PlayerPedId()
			local stressVal  = 0

			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				StressVal = status.val
			end)

			if StressVal == 1000000 then
				Citizen.Wait(15000)
				gozkapatma(math.random(3500,4000))
			elseif StressVal >= 900000 then
				Citizen.Wait(15000)
				gozkapatma(math.random(3250,3500))
			elseif StressVal >= 800000 then
				Citizen.Wait(15000)
				gozkapatma(math.random(3000,3250))
			elseif StressVal >= 700000 then
				Citizen.Wait(15000)
				gozkapatma(math.random(2750,3000))
			elseif StressVal >= 600000 then
				Citizen.Wait(20000)
				gozkapatma(math.random(2500,2750))
			elseif StressVal >= 500000 then
				Citizen.Wait(20000)
				gozkapatma(math.random(2000,2250))
			elseif StressVal >= 350000 then
				Citizen.Wait(20000)
				gozkapatma(math.random(1750,2000))
			else
				Citizen.Wait(3000)
			end
		end
	end)
end)

Citizen.CreateThread(function() -- Silah ile ateş edince
    while true do
        local ped = PlayerPedId()
        local shooting = IsPedShooting(ped)
        local susturucu = IsPedCurrentWeaponSilenced(ped)

        if Config.Shooting then
            if shooting and not susturucu then
                TriggerServerEvent("sup-stress:add", Config.ShootingLevel)
                Citizen.Wait(2000)
            else
                Citizen.Wait(1)
            end
        end
    end
end)

Citizen.CreateThread(function() -- Elinde silah tutarken (Patlayıcılar hariç)
    while true do
        local ped = PlayerPedId()
        local status = IsPedArmed(ped, 4)

		if Config.Armed then
        	if status then
            	TriggerServerEvent("sup-stress:add", Config.ArmedLevel)
            	Citizen.Wait(15000)
        	else
				Citizen.Wait(1)
			end
        end
    end
end)

Citizen.CreateThread(function() -- Yumruk atınca
	while true do
		local ped = PlayerPedId()
		local combat = IsPedInMeleeCombat(ped)

		if Config.Combat then
			if combat then
				TriggerServerEvent("sup-stress:add", Config.CombatLevel)
				Citizen.Wait(5000)
			else
				Citizen.Wait(1)
			end
		end
	end
end)

Citizen.CreateThread(function() -- Nişan alınca
    while true do
        local ped = PlayerPedId()
        local status = GetPedConfigFlag(ped, 78, 1)

		if Config.Flag then
        	if status then
            	TriggerServerEvent("sup-stress:add", Config.FlagLevel)
            	Citizen.Wait(5000)
        	else
				Citizen.Wait(1)
			end
        end
    end
end)

Citizen.CreateThread(function() -- Gizli moda girince
    while true do
        local ped = PlayerPedId()
        local status = GetPedStealthMovement(ped)

		if Config.Movement then
        	if status then
            	TriggerServerEvent("sup-stress:add", Config.MovementLevel)
            	Citizen.Wait(10000)
        	else
				Citizen.Wait(1)
			end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		-- if IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3) then -- Elleri kaldırınca
		-- 	TriggerEvent("sup-stress:add", 10)
		if IsEntityPlayingAnim(ped, 'random@arrests@busted', 'idle_a', 3) then -- /e teslim
			TriggerEvent("sup-stress:add", 15000)
		elseif IsEntityPlayingAnim(ped, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 3)  then -- Sigara İçerken Düşürme
			TriggerServerEvent("sup-stress:remove", 35000)
		elseif IsEntityPlayingAnim(ped, 'amb@world_human_yoga@male@base', 'base_a', 3)  then -- F3 Menüsü Yoga Yaparken Düşürme
			TriggerServerEvent("sup-stress:remove", 35000)
		-- elseif IsEntityPlayingAnim(ped, 'amb@world_human_sit_ups@male@idle_a', 'idle_a', 3)  then -- Mekik
		-- 	TriggerServerEvent("sup-stress:remove", 50000)
		-- elseif IsEntityPlayingAnim(ped, 'amb@prop_human_muscle_chin_ups@male@base', 'base', 3)  then -- Barfiks
		-- 	TriggerServerEvent("sup-stress:remove", 50000)
		elseif IsEntityPlayingAnim(ped, 'timetable@tracy@sleep@', 'idle_c', 3)  then -- Uyuma anim.
			TriggerServerEvent("sup-stress:remove", 75000)
		end
		Citizen.Wait(2000)
	end
end)

function AddStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("sup-stress:add", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("sup-stress:add", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end

function RemoveStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("sup-stress:remove", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("sup-stress:remove", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end

function gozkapatma(time)
	SendNUIMessage({
		action = "ui",
		display = true,
		time = time
	})
end
