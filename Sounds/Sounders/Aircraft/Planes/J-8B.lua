dofile("Aircraft/Planes/Plane.lua")

J_8B = plane:new()
dofile("Aircraft/Engines/J_8B_Engine.lua")
dofile("Aircraft/Engines/APUs/BasicAPU.lua")
function J_8B:createEngines()
	for i = 1, 2 do
		self.engines[i] = J_8B_eng:new()
		self.engines[i]:init(i, host)
		self.engines[i]:initCptNames()
	end
end

function J_8B:createCanopy()
	self.sndCanopyOpen  = ED_AudioAPI.createSource(host, "Aircrafts/A-10/CanopyOpen")
	self.sndCanopyClose = ED_AudioAPI.createSource(host, "Aircrafts/A-10/CanopyClose")
	self.sndCanopyEnd   = ED_AudioAPI.createSource(host, "Aircrafts/A-10/CanopyEnd")
end

local canopyOpenTime = 9.28 + 0.8
local canopyCloseTime = 6.243 + 0.5
local canopyPrevMoveDirection = 0
local canopyPlayStartPhase = 0
function printTableItem(k, v, level)
    local txt=''
    for i = 1, level do
        txt=txt.."\t"
    end
    txt=txt..tostring(k) .. " = " .. tostring(v) .. "\r\n"
    if type(v) == "table" then
        if not tablePrinted[v] then
            tablePrinted[v] = true
            for _k, _v in pairs(v) do
                txt=txt..printTableItem(_k, _v, level + 1)
            end
        end
    end
    return txt
end
function J_8B:updateCanopy(params)
	if params.canopyPos > 0.9 then
		ED_AudioAPI.stopSource(self.sndCanopyOpen)
		ED_AudioAPI.stopSource(self.sndCanopyClose)
		ED_AudioAPI.stopSource(self.sndCanopyEnd)
		do return end
	end
	print(printTableItem("canopyParam",params,0))
	local canopyPosNormalized = params.canopyPos / 0.9
		
	if params.canopyMoveDirection ~= 0 then
		-- is moving
		local canopySndToPlay = nil
		local canopySndToStop = nil

		local gain = 1
		local pitch = 1
		
		local canopyMoveTime = 0
		local soundPos = canopyPosNormalized
		
		if params.canopyMoveDirection <= 0 then
			soundPos = 1 - canopyPosNormalized
		end
		
		if canopyPrevMoveDirection ~= params.canopyMoveDirection then
			canopyPlayStartPhase = soundPos
		end
		
		local wayTravelled = (soundPos - canopyPlayStartPhase) * 100

		if params.canopyMoveDirection > 0 then
			-- opening

			if canopyPlayStartPhase > 0.001 then
				if wayTravelled < 8 then
					gain = -0.0169 * wayTravelled * wayTravelled + 0.2599 * wayTravelled
				end
				
				if wayTravelled < 13.0 then
					pitch = -0.0014 * wayTravelled * wayTravelled + 0.0354 * wayTravelled + 0.7726
				end
			end
			
			canopySndToPlay = self.sndCanopyOpen
			canopySndToStop = self.sndCanopyClose
			
			canopyMoveTime = canopyOpenTime
		else
			-- closing

			if canopyPlayStartPhase > 0.001 then
				if wayTravelled < 15 then
					gain = -0.0048 * wayTravelled * wayTravelled + 0.1387 * wayTravelled
				end
				
				if wayTravelled < 24.04 then
					pitch = -0.0004 * wayTravelled * wayTravelled + 0.0189 * wayTravelled + 0.7726
				end
			end

			canopySndToPlay = self.sndCanopyClose
			canopySndToStop = self.sndCanopyOpen

			canopyMoveTime = canopyCloseTime
		end
		
		gain = math.min(math.max(0, gain), 1)
		pitch = math.min(math.max(0, pitch), 1)

		if canopySndToPlay ~= nil then
			ED_AudioAPI.setSourceGain(canopySndToPlay, gain)
			ED_AudioAPI.setSourcePitch(canopySndToPlay, pitch)
			
			if not ED_AudioAPI.isSourcePlaying(canopySndToPlay) then
				ED_AudioAPI.playSourceOnce(canopySndToPlay, canopyMoveTime * soundPos)
			end
		end
		
		if canopySndToStop ~= nil then
			ED_AudioAPI.stopSource(canopySndToStop)
		end
	elseif canopyPrevMoveDirection ~= 0 then
		-- just stopped

		if canopyPosNormalized > 0 and canopyPosNormalized < 1 then
			ED_AudioAPI.stopSource(self.sndCanopyOpen)
			ED_AudioAPI.stopSource(self.sndCanopyClose)
			ED_AudioAPI.playSourceOnce(self.sndCanopyEnd)
		end
	end

	canopyPrevMoveDirection = params.canopyMoveDirection
end

function J_8B:createCanopyCpt()
	self.cockpit.sndCanopyOpen  = ED_AudioAPI.createSource(self.cockpit.host, "Aircrafts/A-10/Cockpit/CanopyOpenCpt")
	self.cockpit.sndCanopyClose = ED_AudioAPI.createSource(self.cockpit.host, "Aircrafts/A-10/Cockpit/CanopyCloseCpt")
	self.cockpit.sndCanopyEnd   = ED_AudioAPI.createSource(self.cockpit.host, "Aircrafts/A-10/Cockpit/CanopyEndCpt")
	
	ED_AudioAPI.linkSource(self.sndCanopyOpen, self.cockpit.sndCanopyOpen)
	ED_AudioAPI.linkSource(self.sndCanopyClose, self.cockpit.sndCanopyClose)
	ED_AudioAPI.linkSource(self.sndCanopyEnd, self.cockpit.sndCanopyEnd)
end

function J_8B:createCockpit()
	aircraft:createCockpit()
	J_8B:createAPUcpt(self.cockpit.host, "Aircrafts/A-10/APU/")
	J_8B:createCanopyCpt()
end

function J_8B:onUpdate(params)
	aircraft:onUpdate(params)
	J_8B:updateCanopy(params)
end

J_8B:createEngines()
J_8B:createAPU(BasicAPU:new(), host)
J_8B:createCanopy()