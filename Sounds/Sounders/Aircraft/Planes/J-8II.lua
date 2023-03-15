dofile("Aircraft/Planes/Plane.lua")

J_8II = plane:new()
J_8II.CanopyPos = 0
dofile("Aircraft/Engines/J_8II_Engine.lua")
dofile("Aircraft/Engines/APUs/BasicAPU.lua")
function J_8II:createEngines()
	for i = 1, 2 do
		self.engines[i] = J_8II_eng:new()
		self.engines[i]:init(i, host)
		self.engines[i]:initCptNames()
	end
end

function J_8II:createCanopy()
	self.CanopyHost = ED_AudioAPI.createHost(ED_AudioAPI.ContextWorld, "canopyPos")
	self.CanopyHostPos = { 5.461, 0.312, 0.0 }
	self.sndTest = ED_AudioAPI.createSource(host,"Mp3Player/Inside_the_Lines")
	ED_AudioAPI.setSourceGain(self.sndTest, 1)
	ED_AudioAPI.setSourcePitch(self.sndTest, 1)
	self.testCount = 0
	self.sndCanopyOpen  = ED_AudioAPI.createSource(self.CanopyHost, "Aircrafts/A-10/CanopyOpen")
	self.sndCanopyClose = ED_AudioAPI.createSource(self.CanopyHost, "Aircrafts/A-10/CanopyClose")
	self.sndCanopyEnd   = ED_AudioAPI.createSource(self.CanopyHost, "Aircrafts/A-10/CanopyEnd")
	ED_AudioAPI.setSourceGain(self.sndCanopyOpen, 1)
	ED_AudioAPI.setSourcePitch(self.sndCanopyOpen, 1)
	ED_AudioAPI.setSourceGain(self.sndCanopyClose, 1)
	ED_AudioAPI.setSourcePitch(self.sndCanopyClose, 1)
	ED_AudioAPI.setSourceGain(self.sndCanopyEnd, 1)
	ED_AudioAPI.setSourcePitch(self.sndCanopyEnd, 1)
end

function J_8II:updateCanopyHost(params)
	ED_AudioAPI.setHostPosition(self.CanopyHost, params.posx+self.CanopyHostPos[1], params.posy+self.CanopyHostPos[3], params.posz+self.CanopyHostPos[2])
	ED_AudioAPI.setHostOrientation(self.CanopyHost, params.orienta, params.orientb, params.orientc, params.orientd)
	ED_AudioAPI.setHostVelocity(self.CanopyHost, params.velx, params.vely, params.velz)
end

function J_8II:updateCanopy(params)
	if params.canopyPos >= 0.9 then
		ED_AudioAPI.stopSource(self.sndCanopyOpen)
		ED_AudioAPI.stopSource(self.sndCanopyClose)
		ED_AudioAPI.stopSource(self.sndCanopyEnd)
	else
		if self.CanopyPos ~= params.canopyPos then
			-- is moving
			if ED_AudioAPI.isSourcePlaying(self.sndCanopyEnd) then
				ED_AudioAPI.stopSource(self.sndCanopyEnd)
			end
			if params.canopyPos > 0 and params.canopyPos < 0.9 and params.canopyPos-self.CanopyPos > 0 and not ED_AudioAPI.isSourcePlaying(self.sndCanopyOpen) then
				ED_AudioAPI.playSourceLooped(self.sndCanopyOpen)
				ED_AudioAPI.stopSource(self.sndCanopyClose)
			elseif params.canopyPos > 0 and params.canopyPos < 0.9 and params.canopyPos-self.CanopyPos < 0 and not ED_AudioAPI.isSourcePlaying(self.sndCanopyClose) then
				ED_AudioAPI.playSourceLooped(self.sndCanopyClose)
				ED_AudioAPI.stopSource(self.sndCanopyOpen)
			end
		else
			-- is Stop
			if not ED_AudioAPI.isSourcePlaying(self.sndCanopyEnd) then
				ED_AudioAPI.playSourceOnce(self.sndCanopyEnd)
			end
			if ED_AudioAPI.isSourcePlaying(self.sndCanopyOpen) then
				ED_AudioAPI.stopSource(self.sndCanopyOpen)
			end
			if ED_AudioAPI.isSourcePlaying(self.sndCanopyClose) then
				ED_AudioAPI.stopSource(self.sndCanopyClose)
			end
		end
	end
	self.CanopyPos = params.canopyPos
end

function J_8II:createCanopyCpt()
	self.cockpit.sndCanopyOpen  = ED_AudioAPI.createSource(self.cockpit.host, "Aircrafts/A-10/Cockpit/CanopyOpenCpt")
	self.cockpit.sndCanopyClose = ED_AudioAPI.createSource(self.cockpit.host, "Aircrafts/A-10/Cockpit/CanopyCloseCpt")
	self.cockpit.sndCanopyEnd   = ED_AudioAPI.createSource(self.cockpit.host, "Aircrafts/A-10/Cockpit/CanopyEndCpt")

	ED_AudioAPI.linkSource(self.sndCanopyOpen, self.cockpit.sndCanopyOpen)
	ED_AudioAPI.linkSource(self.sndCanopyClose, self.cockpit.sndCanopyClose)
	ED_AudioAPI.linkSource(self.sndCanopyEnd, self.cockpit.sndCanopyEnd)
end

function J_8II:createCockpit()
	aircraft:createCockpit()
	J_8II:createAPUcpt(self.cockpit.host, "Aircrafts/A-10/APU/")
	J_8II:createCanopyCpt()
end
function J_8II:testFunction()
	if self.testCount == 0 then
		ED_AudioAPI.playSourceLooped(self.sndTest)
	elseif self.testCount > 60 then
		ED_AudioAPI.stopSource(self.sndTest)
	end
	self.testCount = self.testCount + 0.02
end

function aircraft:onUpdate(params)
	updateHost(host, params)

	for k, v in pairs(self.engines) do
		if params.DBG_playEngines == 0 then
			v:DBGstop()
		else
			v:update(params["coreRPM_"..k], params["fanRPM_"..k], params["turbPower_"..k], params["thrust_"..k], params["flame_"..k])
		end
	end
	
	if self.APU.initialized then
		self.APU.item:update(params)
	end

	if self.cockpit.initialized then
		self:updateGbreath(params)
	end
	
	J_8II:onUpdate(params)
end

function J_8II:onUpdate(params)
	J_8II:updateCanopy(params)
	J_8II:updateCanopyHost(params)
end

J_8II:createEngines()
aircraft:createAPU(BasicAPU:new(), host)
J_8II:createCanopy()
