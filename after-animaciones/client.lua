Citizen.CreateThread(function()
    local dict = "amb@world_human_hang_out_street@female_arms_crossed@base"
    
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
    local handsup = false
	while true do
		Citizen.Wait(0)
		if IsControlJustPressed(1, 47) then --Start holding G cruzarse de brazos
            if not handsup then
                TaskPlayAnim(GetPlayerPed(-1), dict, "base", 8.0, 8.0, -1, 50, 0, false, false, false)
                handsup = true
            else
                handsup = false
                ClearPedTasks(GetPlayerPed(-1))
            end
        end
    end
end)


--New custom animations based off DavesEmotes from @davewazere
--https://forum.fivem.net/t/release-daves-emotes/140216 
--Finger Pointing is taken from @Geekness and @Hallux
--https://forum.fivem.net/t/release-finger-pointing-by-geekness/103722
--Ragdoll is from here @callmejaf
--https://forum.fivem.net/t/release-toggle-ragdoll/53668
--Crouch is from wolfknights script @WolfKnight
--https://forum.fivem.net/t/release-crouch-script-1-0-1-now-button-based/14742


-- Commands
-- Salute: 		/e salute 		: Salute your commrads!
-- Bird 1: 		/e finger 		: One hand middle Finger
-- Bird 2: 		/e finger2 		: 2 hands middle finger
-- Surrender: 	/e surrender	: Kneeldown hands behind head surrender
-- Facepalm: 	/e palm			: Facepalm
-- Notes: 		/e notes		: Write down notes on paper
-- Brief:		/e brief		: Equip a tactical brief case
-- Brief2:		/e brief2		: Equip a leather brief case
-- Foldarms:	/e foldarms		: Cross your arms 
-- Foldarms2: 	/e foldarms2	: Cross arms v2
-- Damn:		/e damn			: Throw your arms in disbelief
-- Fail:		/e fail			: Become visibly dissapointed
-- Gang1:		/e gang1		: Gang sign 1
-- Gang2:		/e gang2		: Gang sign 2
-- No:			/e no			: Shake your head no
-- Pickbutt:	/e pickbutt		: Pick your butt
-- Grab Crotch:	/e grabcrotch	: Grab your crotch
-- Peace:		/e peace		: Hold peace sign
-- Cigar:		/e cigar		: Place cigar in your mouth
-- Cigar2:		/e cigar2		: Place a burnt cigar in your mouth
-- Joint:		/e joint		: Place a joint in your mouth
-- Cig:			/e cig			: Place a cig in your mouth
-- Holdcigar:	/e holdcigar	: Hold a cigar in your hand 
-- Holdcig:		/e holdcig		: Hold a cig in your hand 
-- Holdjoint:	/e holdjoint	: Hold a joint in your hand
-- Dead:		/e dead			: Play dead
-- Holster:		/e holster		: Hand hovers over holster 
-- Aim:			/e aim			: Aim a pistol at the floor 
-- Aim2:		/e aim2			: Aim a pistol up to your shoulder
-- 				/e slowclap		: Slowly clap your hands
--				/e box			: Pull out a box and walk around with it
--				/e cheer		: Cheer
--				/e bum			: Lay on the ground like a bum
--				/e leanwall		: Lean against a wall
--				/e copcrowd1	: Calm down a crowd like a cop
--				/e copcrowd2	: Control a scene like a cop
--				/e copidle		: idle like a cop


-- If you want ESX features enabled you can uncomment this stuff
--------------------------------------------------------------------------------------------- ESX SUPPORT ---------------------------------------------------------------------------------------------


ESX 			    			= nil
local PlayerData 				= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

------------------------------------------------------------------------------------------ END ESX SUPPORT ------------------------------------------------------------------------------------------

local radioActive 				= false
local radioButton				= -1 --- Y by default  -- use 57 for f10 --- hablar por radio (accion)
local handsUpButton				= 73 --- X by default -- use 73 for X manos levantadas



--- Function for radio chatter function
Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustPressed(0,radioButton)) then
		if (IsControlJustPressed(0,radioButton))  then
			local ped = PlayerPedId()
			--TriggerEvent('chatMessage', 'TESTING ANIMATION')
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = true
	
				if radioActive then
	
					RequestAnimDict( "random@arrests" )
	
					while ( not HasAnimDictLoaded( "random@arrests" ) ) do 
						Citizen.Wait( 100 )
					end
	
					if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
						ClearPedSecondaryTask(ped)
					else
						TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
						local prop_name = prop_name
						local secondaryprop_name = secondaryprop_name
						DetachEntity(prop, 1, 1)
						DeleteObject(prop)
						DetachEntity(secondaryprop, 1, 1)
						DeleteObject(secondaryprop)
						--SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
					end
				end
			end
		end
	end
end)
	
--- Broke this into two functions because it was bugging out for some reason.
	
Citizen.CreateThread( function()
	
	while true do
		Citizen.Wait(0)
		-- if you use ESX Framework and want this to be a cop only thing then replace the line below this with the following:
		-- if (PlayerData.job ~= nil and PlayerData.job.name == 'police') and (IsControlJustReleased(0,57))  and (radioActive) then
		if (IsControlJustReleased(0,raisehandbutton))  and (radioActive) then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
				radioActive = false
				ClearPedSecondaryTask(ped)
				--SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
			end
		end

			
	end
	
end)


Citizen.CreateThread( function()

	while true do
		Citizen.Wait(0)
		if (IsControlJustPressed(0,handsUpButton))  then
			local ped = PlayerPedId()
	
			if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
	
				RequestAnimDict( "random@mugging3" )
	
				while ( not HasAnimDictLoaded( "random@mugging3" ) ) do 
					Citizen.Wait( 100 )
				end
	
				if IsEntityPlayingAnim(ped, "random@mugging3", "handsup_standing_base", 3) then
					ClearPedSecondaryTask(ped)
				else
					TaskPlayAnim(ped, "random@mugging3", "handsup_standing_base", 2.0, 2.5, -1, 49, 0, 0, 0, 0 )
					local prop_name = prop_name
					local secondaryprop_name = secondaryprop_name
					DetachEntity(prop, 1, 1)
					DeleteObject(prop)
					DetachEntity(secondaryprop, 1, 1)
					DeleteObject(secondaryprop)
				end
			end
		end
	end
end)


RegisterCommand("e",function(source, args)
	local player = PlayerPedId()
	if tostring(args[1]) == nil then
		print("Invalid syntax, correct syntax is: /e <animation> ")
		return
	else
		if tostring(args[1]) ~= nil then
            local argh = tostring(args[1])



				Citizen.CreateThread(function() --disabling controls while surrendured
					while surrendered do
						Citizen.Wait(0)
						if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
							DisableControlAction(1, 140, true)
							DisableControlAction(1, 141, true)
							DisableControlAction(1, 142, true)
							DisableControlAction(0,21,true)
						end
					end
				end)

			if argh == 'foldarms2' then
				local ad = "missfbi_s4mop"
				
				
				if ( DoesEntityExist( player ) and not IsEntityDead( player )) then 
					loadAnimDict( ad )
					if ( IsEntityPlayingAnim( player, ad, "guard_idle_a", 3 ) ) then 
						TaskPlayAnim( player, ad, "exit", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					else
						TaskPlayAnim( player, ad, "guard_idle_a", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
					end 
				end

			
			
			
				
		
			end
		end
	end
end, false)

----Use /testanimation command, you can use this to easily test new animations---
--[[ COMANDO Y ANIMACION
RegisterCommand("testanimation",function(source, args)

	local ad = "amb@code_human_police_crowd_control@idle_b" --- insert the animation dic here
	local anim = "idle_d" --- insert the animation name here
	local player = PlayerPedId()
	

	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		TriggerEvent('chatMessage', '^2 Testing Animation')
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then 
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end       
	end
end, false)
--]]
	
----------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ functions -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500)
		if IsPedRagdoll(PlayerPedId()) then 
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end
	end
end)	

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end


------apuntar con el dedo

local mp_pointing = false
local keyPressed = false

local function startPointing()
    local ped = GetPlayerPed(-1)
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()
    local ped = GetPlayerPed(-1)
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(0)

        if once then
            once = false
        end

        if not keyPressed then
            if IsControlPressed(0, 29) and not mp_pointing and IsPedOnFoot(PlayerPedId()) then
                Wait(200)
                if not IsControlPressed(0, 29) then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                else
                    keyPressed = true
                    while IsControlPressed(0, 29) do
                        Wait(50)
                    end
                end
            elseif (IsControlPressed(0, 29) and mp_pointing) or (not IsPedOnFoot(PlayerPedId()) and mp_pointing) then
                keyPressed = true
                mp_pointing = false
                stopPointing()
            end
        end

        if keyPressed then
            if not IsControlPressed(0, 29) then
                keyPressed = false
            end
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
            stopPointing()
        end
        if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
            if not IsPedOnFoot(PlayerPedId()) then
                stopPointing()
            else
                local ped = GetPlayerPed(-1)
                local camPitch = GetGameplayCamRelativePitch()
                if camPitch < -70.0 then
                    camPitch = -70.0
                elseif camPitch > 42.0 then
                    camPitch = 42.0
                end
                camPitch = (camPitch + 70.0) / 112.0

                local camHeading = GetGameplayCamRelativeHeading()
                local cosCamHeading = Cos(camHeading)
                local sinCamHeading = Sin(camHeading)
                if camHeading < -180.0 then
                    camHeading = -180.0
                elseif camHeading > 180.0 then
                    camHeading = 180.0
                end
                camHeading = (camHeading + 180.0) / 360.0

                local blocked = 0
                local nn = 0

                local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                nn,blocked,coords,coords = GetRaycastResult(ray)

                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)

            end
        end
    end
end)
