ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('esx_status:loaded', function(status)
	TriggerEvent('esx_status:registerStatus', 'stress', 1000000, '#cadfff', function(status)
		return false
	end, function(status)
		status.add(1)
	end)

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(5)
			local PlayerPed = PlayerPedId()
			local stressVal  = 0

			TriggerEvent('esx_status:getStatus', 'stress', function(status)
				StressVal = status.val
			end)

			if StressVal == 1000000 then
				Citizen.Wait(5000)
				gozkapatma(math.random(5250,5500))
			elseif StressVal >= 900000 then
				Citizen.Wait(8000)
				gozkapatma(math.random(4750,5000))
			elseif StressVal >= 800000 then
				Citizen.Wait(10000)
				gozkapatma(math.random(4500,4750))
			elseif StressVal >= 700000 then
				Citizen.Wait(15000)
				gozkapatma(math.random(4000,4250))
			elseif StressVal >= 600000 then
				Citizen.Wait(25000)
				gozkapatma(math.random(3750,4000))
			elseif StressVal >= 500000 then
				Citizen.Wait(40000)
				gozkapatma(math.random(3500,3750))
			elseif StressVal >= 350000 then
				Citizen.Wait(45000)
				gozkapatma(math.random(3250,3500))
			elseif StressVal >= 200000 then
				Citizen.Wait(50000)
				gozkapatma(math.random(3000,3250))
			elseif StressVal >= 125000 then
				Citizen.Wait(55000)
				gozkapatma(math.random(2750,3000))
			elseif StressVal >= 75000 then
				Citizen.Wait(60000)
				gozkapatma(math.random(2500,2750))
			else
				Citizen.Wait(5000)
			end
		end
	end)
end)

Citizen.CreateThread(function() -- Silah ile ateş edince
	while true do
        local PlayerPed = PlayerPedId()
        local shooting = IsPedShooting(PlayerPed)

		if shooting then
			TriggerServerEvent("stress:add", 4000)
			Citizen.Wait(2000)
		else
			Citizen.Wait(5)
		end
    end
end)

Citizen.CreateThread(function() -- Yumruk atınca
	while true do
		local PlayerPed = PlayerPedId()
		local combat = IsPedInMeleeCombat(PlayerPed)

		if combat then
			TriggerServerEvent("stress:add", 100)
			Citizen.Wait(5000)
		else
			Citizen.Wait(5)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local PlayerPed = PlayerPedId()
		if IsEntityPlayingAnim(PlayerPed, 'random@arrests@busted', 'idle_a', 3) then -- /e teslim
			TriggerServerEvent("stress:add", 2500)
		elseif IsEntityPlayingAnim(PlayerPed, 'amb@world_human_smoking@male@male_b@idle_a', 'idle_a', 3)  then -- Sigara İçerken Düşürme
			TriggerServerEvent("stress:remove", 25000)
		elseif IsEntityPlayingAnim(PlayerPed, 'timetable@tracy@sleep@', 'idle_c', 3)  then -- Uyuma anim.
			TriggerServerEvent("stress:remove", 50000)
		end
		Citizen.Wait(5000)
	end
end)

function AddStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("stress:add", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("stress:add", value/seconds)
            count = count + 1
            Citizen.Wait(1000)
        until count == seconds
    end
end

function RemoveStress(method, value, seconds)
    if method:lower() == "instant" then
        TriggerServerEvent("stress:remove", value)
    elseif method:lower() == "slow" then
        local count = 0
        repeat
            TriggerServerEvent("stress:remove", value/seconds)
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
